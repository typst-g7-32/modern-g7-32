#import "/src/export.typ": appendixes, gost

#show: gost.with(hide-title: true)

= Основная часть
#figure([], caption: "Элемент из основной части") <main-element>

Ссылка на рисунок @sub-appendix-element, @appendix-element.

#show: appendixes

= Приложение
#figure([], caption: "Элемент из приложения") <appendix-element>

Ссылка на рисунок @main-element.

= Промежуток

Ссылка на рисунок @main-element.

== Приложение второго уровня
#figure(
  [],
  caption: "Элемент из приложения второго уровня",
) <sub-appendix-element>

Ссылка на рисунок @main-element.
