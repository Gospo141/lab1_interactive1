# Розумний дім

Лабораторні роботи з дисципліни «Розроблення мобільних додатків».
Студент: Рудик Андрій, КБ-410.

## Лабораторна робота №3

Додано валідацію реєстрації та входу й локальний CRUD пристроїв. SharedPreferences зберігає профілі й пристрої в JSON. Інтерфейси репозиторіїв лежать у domain, реалізації — в data, а GetIt надає їх екранам із features.

[Методичні вказівки](https://github.com/Berezhnyj/mobile-app-development-labs/tree/lab-03).

## Скриншоти зі звіту

- [Помилки валідації](screenshots/lab-03/validation.png)
- [Успішна реєстрація](screenshots/lab-03/registered.png)
- [Успішний вхід](screenshots/lab-03/signed-in.png)
- [Створення пристрою](screenshots/lab-03/add-device.png)
- [Редагування](screenshots/lab-03/edit-device.png)
- [Видалення](screenshots/lab-03/delete-device.png)
- [Дані після перезапуску](screenshots/lab-03/after-restart.png)

## Запуск

```sh
flutter pub get
flutter run
```
