from graphviz import Digraph

dot = Digraph()

dot.node("API", "OpenAQ API")
dot.node("ING", "Ingestion")
dot.node("VAL", "Validation")
dot.node("TR", "Transformation")
dot.node("DB", "PostgreSQL")
dot.node("SQL", "Analytics SQL")
dot.node("BI", "Dashboard")

dot.edges([
    ("API", "ING"),
    ("ING", "VAL"),
    ("VAL", "TR"),
    ("TR", "DB"),
    ("DB", "SQL"),
    ("SQL", "BI")
])

dot.render("architecture")
