#import "/src/export.typ": gost, custom-title-template.from-module
#import "template.typ" as custom-template

#show: gost.with(
  title-template: from-module(custom-template),
  institute: (number: 3, name: "Системы управления, информатика и электроэнергетика"),
  department: (number: 307, name: "Цифровые технологии и информационные системы"),
  performers: (
    (name: "Елисеев П.А.", position: "Студент М3О-221Б-23"),
  ),
  bare-subject: false,
  subject: "Пользовательский интерфейс для работы с базой данных",
  manager: (name: "Склеймин Ю.Б.", position: "Преподаватель, доцент кафедры 307"),
  city: "Москва",
)