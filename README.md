MigrateSafely
=============

MigrateSafely is a [railtie](http://api.rubyonrails.org/classes/Rails/Railtie.html) that
adds a confirmation prompt to the `rake db:migrate` command to prevent accidental migrations/rollbacks.

Example:

    $ rake db:migrate

    database: my_database

    Action   Migration ID    Migration Name
    --------------------------------------------------
    apply    20150916005809  Migration1
    apply    20150917011452  Migration2

    Are you sure you want to proceed? [y/n]:

Accidental rollback prevention:

    $ VERSION=foo20150917011452 rake db:migrate      # notice the typo in VERSION

    database: my_database

    Action   Migration ID    Migration Name
    --------------------------------------------------
    revert   20150914175134  Migration100
    revert   20150902002737  Migration099
    revert   20150901221908  Migration098
    revert   20150901171434  Migration097
    revert   20150831194113  Migration096
    ...
    revert   20150101004705  Migration001

    Are you sure you want to proceed? [y/n]:

## License

[MIT License](LICENSE)
