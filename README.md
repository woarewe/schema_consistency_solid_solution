# Checks

1. ColumnPresenceChecker
2. NullConstraintChecker
3. BelongsToPresenceChecker
4. MissingUniqueIndexChecker
5. MissingIndexChecker
6. LengthConstraintChecker
7. PrimaryKeyTypeChecker
8. ForeignKeyTypeChecker


# Plan

1. Create a model User with two fields: email, name. Both are strings
2. Create three endpoints: GET, POST, PUT /users
3. Reproduce the problem
4. Check the tool the author uses to solve the problem
5. Solve the problem in the other way
