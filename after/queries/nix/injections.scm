;; extends

(apply_expression
  (#set! injection.language "nix")

  function: ([
    (select_expression (variable_expression (identifier)) (attrpath (identifier) @_path))
    (variable_expression (identifier) @_path)
  ] (#match? @_path "literalExpression"))

  argument: [
    (_ (string_fragment) @injection.content)

    ; match strings that are under one level of with/let statements
    (_ body: (_ (string_fragment) @injection.content))
  ])
