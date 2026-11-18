# Розумний дім

Лабораторні роботи з дисципліни «Розроблення мобільних додатків».
Студент: Рудик Андрій, КБ-410.

## Лабораторна робота №1

Екран «Розумна лампа» дає змогу змінити яскравість, кімнату та режим лампи.
Лічильник приймає цілі числа, скидається командою `Avada Kedavra` і показує
помилку для некоректного вводу. Стан оновлюється через `setState()`.

- [Додавання цілого числа](screenshots/lab-01/01-add.png).
- [Помилка вводу зі збереженням значення](screenshots/lab-01/02-invalid.png).
- [Скидання командою Avada Kedavra](screenshots/lab-01/03-reset.png).
- [Керування яскравістю лампи у версії зі звіту](screenshots/lab-01/report-lamp.png).

## Запуск і перевірка

```sh
flutter pub get
flutter run
flutter analyze --fatal-infos
flutter test
```

[Методичні вказівки до лабораторної роботи №1](https://github.com/Berezhnyj/mobile-app-development-labs/tree/lab-01).
