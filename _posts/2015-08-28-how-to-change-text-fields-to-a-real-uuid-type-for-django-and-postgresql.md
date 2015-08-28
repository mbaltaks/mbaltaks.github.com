---
layout: post
title: "How to change text fields to a real UUID type for Django and PostgreSQL"
date: 2015-08-28 16:38:18
---
Switch to a dedicated UUID field type, they said, it'll be better they said.

Things are rarely simple.

If you've been storing UUID's as text in [Django](https://www.djangoproject.com) and [PostgreSQL](http://www.postgresql.org) and now want to take advantage of the dedicated UUID type of both [Django >= 1.8](https://docs.djangoproject.com/en/1.8/ref/models/fields/#uuidfield) and [Postgres >= 8.3](http://www.postgresql.org/docs/8.3/static/datatype-uuid.html) then you're wanting to migrate your fields. But the process is not as simple as just changing the type of the field in the model like it usually is.

Posgres does have a way to convert text to uuid, but you have to do it manually because Django won't put that into the migration for you.

Django will most likely create a migration for you that looks something like:

```python
class Migration(migrations.Migration):

    dependencies = [
        ('app', '0001_auto'),
    ]

    operations = [
        migrations.AlterField(
            model_name='modelname',
            name='uuid',
            field=models.UUIDField(db_index=True, unique=True),
        ),
    ]
```

If your uuid field has no indexes or constraints, then you might actually be done, in which case I doubt you're reading this. For those who've found this, it's likely because you have one or both of indexes and constraints.

Here is what I had to do to make this work.

First, put the auto created migration operations into a RunSQL operation as the `state_operations` parameter. This allows you to provide a custom migration, but keep Django informed about what's happened to the database schema.

```python
class Migration(migrations.Migration):

    dependencies = [
        ('app', '0001_auto'),
    ]

    operations = [
    migrations.RunSQL(sql_commands, None, [
            migrations.AlterField(
                model_name='modelname',
                name='uuid',
                field=models.UUIDField(db_index=True, unique=True),
            ),
        ]),
    ]
```

Now you'll need to provide some SQL commands for that `sql_commands` variable. I opted to put the sql into a separate file and then load in with the following python code:

```python
sql_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), '0001.sql')
with open(sql_path, "r") as sqlfile:
    sql_commands = sqlfile.read()
```

Now for the real tricky part, where we actually perform the migration. The basic command you want looks like:

```sql
alter table tablename alter column uuid type uuid using uuid::uuid;
```

But the reason we are here is because of indexes. And as I discovered, Django likes to use your migrations to created randomly named indexes on your fields while running tests, so your tests will fail if you just delete and then recreate a fixed name index or two. So the following is sql that will delete one constraint and all indexes on the text field before converting to a uuid field. It also works for multiple tables in one go.

```sql
DO $$
DECLARE
    table_names text[];
    this_table_name text;
    the_constraint_name text;
    index_names record;

BEGIN

SELECT array['table1',
             'table2'
             ]
    INTO table_names;


FOREACH this_table_name IN array table_names
LOOP
    RAISE notice 'migrating table %', this_table_name;

    SELECT CONSTRAINT_NAME INTO the_constraint_name
    FROM information_schema.constraint_column_usage
    WHERE CONSTRAINT_SCHEMA = current_schema()
        AND COLUMN_NAME IN ('uuid')
        AND TABLE_NAME = this_table_name
    GROUP BY CONSTRAINT_NAME
    HAVING count(*) = 1;
    if the_constraint_name is not NULL then
        RAISE notice 'alter table % drop constraint %',
            this_table_name,
            the_constraint_name;
        execute 'alter table ' || this_table_name
            || ' drop constraint ' || the_constraint_name;
    end if;

    FOR index_names IN
    (SELECT i.relname AS index_name
     FROM pg_class t,
          pg_class i,
          pg_index ix,
          pg_attribute a
     WHERE t.oid = ix.indrelid
         AND i.oid = ix.indexrelid
         AND a.attrelid = t.oid
         AND a.attnum = any(ix.indkey)
         AND t.relkind = 'r'
         AND a.attname = 'uuid'
         AND t.relname = this_table_name
     ORDER BY t.relname,
              i.relname)
    LOOP
        RAISE notice 'drop index %', quote_ident(index_names.index_name);
        EXECUTE 'drop index ' || quote_ident(index_names.index_name);
    END LOOP; -- index_names

    RAISE notice 'alter table % alter column uuid type uuid using uuid::uuid;',
        this_table_name;
    execute 'alter table ' || quote_ident(this_table_name)
        || ' alter column uuid type uuid using uuid::uuid;';
    RAISE notice 'CREATE UNIQUE INDEX %_uuid ON % (uuid);',
        this_table_name, this_table_name;
    execute 'create unique index ' || this_table_name || '_uuid on '
        || this_table_name || '(uuid);';

END LOOP; -- table_names

END;
$$
```

Hopefully this helps you move from text fields to uuid fields without having to do all the work I had to.
