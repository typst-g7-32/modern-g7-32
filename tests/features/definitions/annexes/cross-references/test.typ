#import "/src/export.typ": gost, annexes

#show: gost.with(hide-title: true)

= Основная часть
#figure(
  [],
  caption: "Элемент из основной части"
) <main-element>

Ссылка на рисунок @sub-annex-element, @annex-element.

#show: annexes

= Приложение
#figure(
  [],
  caption: "Элемент из приложения"
) <annex-element>

Ссылка на рисунок @main-element.

= Промежуток

Ссылка на рисунок @main-element.

== Приложение второго уровня
#figure(
  [],
  caption: "Элемент из приложения второго уровня"
) <sub-annex-element>

Ссылка на рисунок @main-element.
