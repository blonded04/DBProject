import peewee as pw
import db_config


def create_database():
    database = pw.PostgresqlDatabase(db_config.PROJECT_DBNAME,
                                     host=db_config.PROJECT_HOST,
                                     user=db_config.PROJECT_USERNAME,
                                     password=db_config.PROJECT_PASSWORD,
                                     port=db_config.PROJECT_PORT)
    return database


def main():
    mydatabase = create_database()
    cursor = mydatabase.cursor()

    '''
    let's imagine for a next seven lines that we don't know anything except for SELECT, GROUP BY, INSERT, DELETE.
    how do we select all characters that came out in version 4.0 or later?
    '''
    cursor.execute("SELECT _id, _version FROM genshindb.updates;")
    new_version_ids = list(map(lambda element: element[0], filter(
        lambda element: element[1] >= 4.0, cursor.fetchall())))
    cursor.execute("SELECT _name, _update FROM genshindb.characters;")
    new_characters_snapshot = sorted(list(map(lambda element: element[0], filter(
        lambda element: (element[1] in new_version_ids), cursor.fetchall()))))
    print(new_characters_snapshot)

    '''
    now let's go real orm
    '''
    class BaseModel(pw.Model):
        class Meta:
            database = mydatabase

    class Character(BaseModel):
        # add only a few fields view provides:
        id = pw.TextField(column_name='_name', unique=True)
        country = pw.TextField(column_name='_country')
        class Meta:
            table_name = 'genshindb.characters'

    '''
    some queries
    '''
    gorou = Character.get(Character.id == "Gorou")
    print("Gorou is from:", gorou.country)

    select_query = Character.select().where(Character.country == "Mondstadt")
    germans = select_query.execute()
    print(germans)

    mydatabase.close()


if __name__ == "__main__":
    main()
