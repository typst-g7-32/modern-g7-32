#import "/src/export.typ": gost, title-templates

#show: gost.with(
  title-template: title-templates.mai-university-lab,
  institute: (number: 3, name: none),
  department: (number: 307, name:none),
  performers: (
    (name: "Лебедев П.А.", position: "Студент М3О-221Б-23"),
  ),

  bare-subject: false,
  subject: "Пользовательский интерфейс для работы с базой данных",
  manager: (name: "Давыдов Ю.Б.", position: "Преподаватель, доцент кафедры 307"),
  city: "Москва",
)
