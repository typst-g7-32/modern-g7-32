#import "/src/export.typ": custom-title-template as utils

#utils.per-line(align: center, [проверка], [проверка], [проверка])

#utils.per-line(align: left, [проверка], [проверка], [проверка])

#utils.per-line(
  align: right,
  (value: [проверка с when-present], when-present: 2),
  (value: [проверка с when-rule], when-rule: true),
  (value: [проверка без условий]),
)

#utils.per-line(
  indent: 0pt,
  align: right,
  (value: [проверка с ложным when-present], when-present: none),
  (value: [проверка с ложным when-rule], when-rule: false),
  (value: [проверка без условий]),
)
