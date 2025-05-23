#import "/src/export.typ": gost, abstract, title-templates

#show: gost.with(
  title-template: title-templates.mai-university-lab,
  performers: (
    (name: "Фамилия И.О.", position: "Должность исполнителя"),
  ),
  institute: (number: 3, name: "Системы управления, информатика и электроэнергетика"),
  department: (number: 307, name: "Цифровые технологии и информационные системы"),
  report-type: "отчёт",
  about: "О лабораторной работе",
  bare-subject: false,
  subject: "Пользовательский интерфейс для работы с базой данных",
  manager: (name: "Фамилия И.О.", position: "Должность руководителя"),
  city: "Москва"
)

#abstract("базы данных", "postgresql", "python", "pyqt5", "телефонный справочник")[
Объектом исследования является база данных телефонного справочника.

Цель работы — разработать базу данных телефонного справочника на
PostgreSQL и программу с графическим интерфейсом для работы с ней.

Лабораторная работа, оформлена в соответствии с ГОСТ 7.32–2017 @gost.

Исходный код проекта доступен в репозитории @repo.
]

#outline()

= Введение
Базы данных являются неотъемлемой частью современных информационных систем.
Они позволяют хранить, обрабатывать и получать
доступ к большим объемам данных. Телефонный справочник, представляющий
собой базу данных контактов, является одним из распространенных примеров
применения баз данных. Удобный пользовательский интерфейс существенно
упрощает взаимодействие с базой данных и повышает эффективность работы.

В данной работе разрабатывается база данных телефонного справочника
на основе PostgreSQL и создается программа с графическим интерфейсом на
языке Python с использованием библиотеки PyQt5. Цель работы – реализовать
функциональный интерфейс, позволяющий выполнять основные операции с
базой данных: добавление, удаление, редактирование записей, поиск, а также
редактирование родительских таблиц.

Работа состоит из нескольких глав. В первой главе описывается структура
разработанной базы данных. Во второй главе рассматривается функционал
разработанной программы. В третьей главе проводится тестирование основных
функций программы. В заключении подводятся итоги работы и формулируются
основные выводы.

= Структура базы данных
База данных телефонного справочника выполнена используя СУБД
PostgreSQL с помощью pgAdmin 4. Она состоит из дочерней таблицы entries и трёх
родительских таблиц: names (имена), surnames (фамилии) и patronymics (отчества).

Структура базы данных представлена на рисунке @database-structure.

#figure(
  image("images/db_diagram.png", width: 300pt),
  caption: "Структура базы данных"
) <database-structure>

Центральной таблицей является таблица entries (записи справочника). Для каждой записи хранятся имя, фамилия, отчество, город, улица, дом, номер квартиры и номер телефона. При этом для повышения эффективности и обеспечения целостности данных имена, фамилии, отчества и улицы хранятся в отдельных родительских таблицах: names, surnames, patronymics и streets соответственно.

В таблице entries хранятся идентификаторы (внешние ключи) соответствующих записей из родительских таблиц и остальные данные.
Родительские таблицы не имеют внешних ключей, они только хранят необходимые записи.

== Таблица записей

Таблица entries является центральной таблицей базы данных и хранит
информацию о каждой записи в телефонном справочнике. Она связана с
другими таблицами через внешние ключи, обеспечивая целостность данных и
предотвращая дублирование информации.

- entry_id (integer, primary key) – уникальный идентификатор записи в таблице.
- name_id (integer, foreign key, not null) – внешний ключ, ссылающийся на таблицу names. Содержит идентификатор имени абонента.
- surname_id (integer, foreign key, not null) – внешний ключ, ссылающийся на таблицу surnames. Содержит идентификатор фамилии абонента.
- patronymic_id (integer, foreign key, not null) – внешний ключ, ссылающийся на таблицу patronymics. Содержит идентификатор отчества абонента.
- street_id (integer, foreign key, not null) – внешний ключ, ссылающийся на таблицу streets. Содержит идентификатор улицы.
- building (text) – номер дома.
- phone (text) – номер телефона.
- apartment (integer) – номер квартиры.

В таблице entries поля name_id, surname_id, patronymic_id и street_id
являются внешними ключами. Они обеспечивают ссылочную целостность,
гарантируя, что каждая запись в entries ссылается на существующую запись в
соответствующей родительской таблице.

Для операций удаления используется правило RESTRICT. Оно
предотвращает удаление записей из родительской таблицы, если на них
существуют ссылки в таблице entries.

Для операций обновления применяется правило CASCADE, которое
обеспечивает автоматическое обновление значений внешних ключей в таблице
entries, если значение первичного ключа в родительской таблице изменяется.

== Родительские таблицы

=== Таблица имен

Таблица names содержит список имен абонентов.

- name_id (integer, primary key) – уникальный идентификатор.
- name (text, not null) – строка с именем.

=== Таблица фамилий

Таблица surnames содержит список фамилий абонентов.

- surname_id (integer, primary key) – уникальный идентификатор.
- surname (text, not null) – строка с фамилией.

=== Таблица отчеств

Таблица patronymics содержит список отчеств абонентов.

- patronymic_id (integer, primary key) – уникальный идентификатор.
- patronymic (text, not null) – строка с отчеством.

=== Таблица улиц

Таблица streets содержит список улиц.

- street_id (integer, primary key) – уникальный идентификатор.
- street (text, not null) – название улицы.

= Программная реализация
Программа для работы с телефонным справочником была разработана с использованием библиотеки PyQt5,
обеспечивающей графический пользовательский интерфейс.

Основные функции приложения — создание, просмотр, редактирование и удаление данных через удобный интерфейс

== Основные технологии

Программа использует следующие технологии:
- PyQt5 — создание графического интерфейса;
- psycopg2 — взаимодействие с базой данных PostgreSQL;
- loguru — логирование событий и ошибок;
- python-dotenv — управление конфигурацией через файл .env;
- pydantic — валидация входных данных;
- mimesis — генерация случайных данных.

== Графический интерфейс

Интерфейс включает таблицу с данными, где пользователь может:
- просматривать текущие записи;
- добавлять новые записи через кнопку «Создать запись»;
- удалять или дублировать записи через контекстное меню.

Графический интерфейс программы представлен на рисунке @program_screenshot.

#figure(
  image("images/program_screenshot.png", width: 324pt),
  caption: "Графический интерфейс программы"
) <program_screenshot>

Интерфейс родительской таблицы изображён на рисунке @parent_table.

#figure(
  image("images/parent_table.png"),
  caption: "Интерфейс для родительской таблицы"
) <parent_table>

Внешние ключи в базе данных отображаются в интерфейсе как
выпадающие списки (рисунок @foreign_key_choice), позволяя пользователю выбирать доступные
значения без необходимости ручного ввода.

#figure(
  image("images/foreign_key_choice.png"),
  caption: "Выпадающий список"
) <foreign_key_choice>

Контекстное меню программы (рисунок @context_menu) поддерживает работу с
несколькими выбранными строками и предоставляет следующие опции с
горячими клавишами:

- ”Создать запись”(Ins)
- ”Дублировать запись”(Ctrl+D)
- ”Удалить запись”(Del)

Эти действия могут быть применены как к одной, так и к нескольким
выделенным строкам таблицы.

#figure(
  image("images/context_menu.png"),
  caption: "Контекстное меню для управления записями"
) <context_menu>

== Логирование

Логирование осуществляется с помощью библиотеки loguru. Это
позволяет отслеживать выполнение программы, фиксировать ошибки и
выводить информацию о происходящих событиях.

#figure(
  image("images/log_output.png", width: 65%),
  caption: "Пример вывода логов программы"
) <log_output>

Логирование, помимо общей информации о работе программы, также
выводит SQL-запросы, отправляемые в базу данных. Это позволяет наглядно
продемонстрировать взаимодействие программы с базой данных, отследить ход
выполнения запросов и, при необходимости, использовать эту информацию
для отладки или анализа производительности. Вывод SQL-запросов в лог
существенно упрощает понимание того, как программа работает с данными.

Пример вывода логов программы представлен на рисунке @log_output.

== Конфигурация

Для управления параметрами подключения к базе данных используется файл .env. Это позволяет изменять настройки без необходимости редактирования исходного кода программы.
Пример содержимого файла конфигурации представлен на рисунке 7.

#figure(
  image("images/dotenv.png"),
  caption: "Пример содержимого файла конфигурации .env"
) <dotenv>

== Дополнительные функции

Для автоматического заполнения базы данных используется библиотека mimesis. Пользователь может указать количество записей через диалоговое окно (рисунок @fill_db_dialog).

#figure(
  image("images/fill_db_dialog.png", width: 40%),
  caption: "Диалоговое окно для заполнения базы данных"
) <fill_db_dialog>

Функция сброса базы данных удаляет все записи из таблиц и обнуляет
счётчики PostgreSQL, используя команды SQL. Пользователь может отменить
операцию сброса базы данных через диалоговое окно (рисунок @reset_db_dialog).

#figure(
  image("images/reset_db_dialog.png", width: 60%),
  caption: "Диалоговое окно сброса базы данных"
) <reset_db_dialog>

= Тестирование
== Добавление записи

Тестирование показало корректную работу добавления новых записей в справочник.
На рисунке @before_create представлен интерфейс перед добавлением записи, а на рисунке @after_create — после успешного добавления.

#figure(
  image("images/tests/before_create.png", width: 300pt),
  caption: "Интерфейс перед добавлением записи"
) <before_create>

#figure(
  image("images/tests/after_create.png", width: 300pt),
  caption: "Интерфейс после добавления записи"
) <after_create>

#pagebreak()

== Удаление записи

Удаление записей работает корректно. На рисунке @before_delete представлен интерфейс перед удалением записи, а на рисунке @after_delete — после удаления.

#figure(
  image("images/tests/before_delete.png", width: 300pt),
  caption: "Интерфейс перед удалением записи"
) <before_delete>

#figure(
  image("images/tests/after_delete.png", width: 300pt),
  caption: "Интерфейс после удаления записи"
) <after_delete>

#pagebreak()

== Редактирование записи

Изменение данных в существующих записях работает корректно. На рисунке @before_update представлен интерфейс перед редактированием записи, а на рисунке @after_update — после редактирования.

#figure(
  image("images/tests/before_update.png", width: 300pt),
  caption: "Интерфейс перед редактированием записи"
) <before_update>

#figure(
  image("images/tests/after_update.png", width: 300pt),
  caption: "Интерфейс после редактирования записи"
) <after_update>

#pagebreak()

== Поиск

Тестирование поиска по различным критериям показало корректность работы функции поиска. Поиск осуществляется по всем колонкам таблицы, что позволяет быстро находить нужные записи по любому из доступных атрибутов. На рисунке @before_search представлен интерфейс перед поиском, а на рисунке @after_search — после ввода текста в поле для поиска.

#figure(
  image("images/tests/before_search.png", width: 300pt),
  caption: "Интерфейс перед поиском"
) <before_search>

#figure(
  image("images/tests/after_search.png", width: 300pt),
  caption: "Интерфейс после поиска"
) <after_search>

#pagebreak()

== Генерация данных

Генерация данных работает корректно. На рисунке @before_generate представлен интерфейс перед генерацией данных, а на рисунке @after_generate — после генерации.

#figure(
  image("images/tests/before_generate.png", width: 300pt),
  caption: "Интерфейс перед генерацией данных"
) <before_generate>

#figure(
  image("images/tests/after_generate.png", width: 300pt),
  caption: "Интерфейс после генерации данных"
) <after_generate>

#pagebreak()

== Сброс данных

Сброс данных работает корректно. На рисунке @before_reset представлен интерфейс перед сбросом данных, а на рисунке @after_reset — после сброса.

#figure(
  image("images/tests/before_reset.png", width: 300pt),
  caption: "Интерфейс перед сбросом данных"
) <before_reset>

#figure(
  image("images/tests/after_reset.png", width: 300pt),
  caption: "Интерфейс после сброса данных"
) <after_reset>

#pagebreak()

== Нарушение ссылочной целостности

Ограничения ссылочной целостности предотвращают удаление записей из родительских таблиц, на которые есть ссылки. На рисунке @before_delete_error представлена попытка удаления записи из родительской таблицы, на которую ссылаются записи в главной таблице. На рисунке @after_delete_error показано сообщение об ошибке, указывающее на нарушение ссылочной целостности.

#figure(
  image("images/tests/before_delete_error.png", width: 300pt),
  caption: "Попытка удаления записи из родительской таблицы"
) <before_delete_error>

#figure(
  image("images/tests/after_delete_error.png", width: 300pt),
  caption: "Сообщение об ошибке нарушения ссылочной целостности"
) <after_delete_error>

#pagebreak()

== Редактирование родительских таблиц

Добавление, редактирование и удаление записей в родительских таблицах работают корректно. На рисунке @before_parent_update представлен интерфейс перед изменением родительской таблицы, а на рисунке @after_parent_update — после изменения.

#figure(
  image("images/tests/before_parent_update.png", width: 300pt),
  caption: "Интерфейс перед изменением родительской таблицы"
) <before_parent_update>

#figure(
  image("images/tests/after_parent_update.png", width: 300pt),
  caption: "Интерфейс после изменения родительской таблицы"
) <after_parent_update>

= Заключение
В рамках данной лабораторной работы была разработана и реализована
реляционная база данных для телефонного справочника, используя систему
управления базами данных PostgreSQL.
Архитектура базы данных спроектирована с учетом требований
целостности и эффективности хранения данных, обеспечивая оптимальную
организацию информации.

Для взаимодействия с базой данных было разработано пользовательское
приложение с графическим интерфейсом на базе библиотеки PyQt5.
Приложение предоставляет функционал для выполнения основных операций:
добавление, просмотр, редактирование и удаление записей. Использование
выпадающих списков для выбора значений внешних ключей упрощает
работу пользователя и предотвращает ошибки, связанные с вводом данных.

Дополнительные функции автоматизации, такие как заполнение и сброс данных,
повышают удобство использования приложения. Внедрение логирования с
помощью библиотеки loguru обеспечивает прозрачность работы приложения
и позволяет отслеживать SQL-запросы, что упрощает отладку и анализ
производительности.

Тщательное тестирование подтвердило корректность работы всех
реализованных функций. Механизмы обеспечения ссылочной целостности
гарантируют надежность хранения данных и защищают от непреднамеренного
удаления связанной информации.

В результате, поставленные задачи были выполнены. Разработанная
база данных и приложение для работы с ней полностью соответствуют
заданным требованиям и демонстрируют эффективность выбранных подходов
к проектированию и реализации.

#bibliography("references.bib")
