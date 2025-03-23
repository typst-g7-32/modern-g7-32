#import "/src/export.typ": gost, title-templates

#show: gost.with(
  title-template: title-templates.mai-university-lab,
  institute: (number: none, name: "Системы управления, информатика и электроэнергетика"),
  department: (number: none, name: "Цифровые технологии и информационные системы"),
  performers: (
    (name: "Лебедев П.А.", position: "Студент М3О-221Б-23"),
  ),

  bare-subject: false,
  subject: "Пользовательский интерфейс для работы с базой данных",
  manager: (name: "Давыдов Ю.Б.", position: "Преподаватель, доцент кафедры 307"),
  city: "Москва",
)
