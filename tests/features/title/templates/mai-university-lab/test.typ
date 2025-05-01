#import "/src/export.typ": gost, title-templates

#show: gost.with(
  title-template: title-templates.mai-university-lab,
  institute: (number: 3, name: "Системы управления, информатика и электроэнергетика"),
  department: (number: 307, name: "Цифровые технологии и информационные системы"),
  performers: (
    (name: "Фамилия И.О.", position: "Студент"),
  ),

  bare-subject: false,
  subject: "Пользовательский интерфейс для работы с базой данных",
  manager: (name: "Фамилия И.О.", position: "Преподаватель"),
  city: "Москва",
)
