(
  (raw_string_literal
    (raw_string_content) @injection.content)

  (#any-contains? @injection.content
    "SELECT" "select"
    "INSERT" "insert"
    "UPDATE" "update"
    "DELETE" "delete"
    "WITH"   "with"
    "CREATE" "create"
    "ALTER"  "alter"
    "DROP"   "drop"
    "TRUNCATE" "truncate"
    "REPLACE"  "replace"
    "MERGE"    "merge"
    "FROM"   "from"
    "WHERE"  "where"
    "JOIN"   "join"
    "GROUP BY" "group by"
    "ORDER BY" "order by"
    "LIMIT"  "limit"
    "VALUES" "values"
    "INTO"   "into"
    "RETURNING" "returning"
    "UNION"  "union"
    "EXPLAIN" "explain"
    "PRAGMA"  "pragma"
    "VACUUM"  "vacuum"
    "ANALYZE" "analyze"
    "BEGIN"   "begin"
    "COMMIT"  "commit"
    "ROLLBACK" "rollback")

  (#set! injection.language "sql")
)