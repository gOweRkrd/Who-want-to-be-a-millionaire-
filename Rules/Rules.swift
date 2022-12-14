//
//  Rules.swift
//  Who want to be a millionaire?
//
//  Created by Alexander Altman on 02.11.2022.
//

import Foundation

struct Rules {
    let rules = """
  Игра Кто хочет стать миллионером? - это конкурс викторина, в котором участники должны правильно ответить на ряд вопросов с несколькими вариантами ответов, чтобы перейти на следующий уровень. Всего 15 вопросов, каждый вопрос стоит определенной суммы денег, участники не имеют никаких временных ограничений для предоставления ответа. Участники также получают три вида подсказок, чтобы помочь себе, если они застряли на конкретном вопросе.
  Вопросы 'Кто хочет стать миллионером?' структурированы в соответствии с пятью различными уровнями, причем уровень сложности постепенно увеличивается. Каждый уровень содержит три вопроса.
  Вопросы, сгруппированные на одном уровне, будут иметь одинаковую сложность. Например: вопросы 1-3 составляют первый уровень и будут содержать самые простые вопросы. Второй уровень (вопросы 4–6) будет несколько сложнее, за ним следует третий уровень (вопросы 7–9). Четвертый уровень (вопросы 10–12) будет состоять из действительно сложных вопросов, за которыми следует пятый и последний уровень (вопросы 13–15), имеющий самые сложные вопросы в игре.
  Важно помнить, что вопросы, составляющие каждый уровень, не обязательно будут относиться к одним и тем же или даже сходным темам, но их общий уровень сложности будет одинаковым. Немаловажно, что уровни вопросов не следует путать с «несгораемыми суммами» или структурой ценностей вопросов, что они собой являют объясняется ниже.
  Важно помнить, что вопросы, составляющие каждый уровень, не обязательно будут относиться к одним и тем же или даже сходным темам, но их общий уровень сложности будет одинаковым. Немаловажно, что уровни вопросов не следует путать с «несгораемыми суммами» или структурой ценностей вопросов, что они собой являют объясняется ниже.
◉ Вопрос 1 - 100 руб.
◉ Вопрос 2 - 200 руб.
◉ Вопрос 3 - 300 руб.
◉ Вопрос 4 - 500 руб.
◉ Вопрос 5 - 1000 руб.
=================
Несгораемая сумма. Если участники неправильно отвечают на этот вопрос вопрос, то они уходят ни с чем. Если на этот вопрос дан правильный ответ, участникам гарантируется 1000 рублей, даже если дадут неверный ответ до достижения следующей несгораемой суммы в десятом вопросе.
=================
◉ Вопрос 6 - 2000 руб.
◉ Вопрос 7 - 4000 руб.
◉ Вопрос 8 - 8000 руб.
◉ Вопрос 9 - 16000 руб.
◉ Вопрос 10 - 32000 руб.
=================
Несгораемая сумма. Если участники неправильно отвечают на этот вопрос вопрос, то они уходят ни с чем. Если на этот вопрос дан правильный ответ, участникам гарантируется 1000 рублей, даже если дадут неверный ответ до достижения следующей несгораемой суммы в десятом вопросе.
=================
◉ Вопрос 11 - 64000 руб.
◉ Вопрос 12 - 125000 руб.
◉ Вопрос 13 - 250000 руб.
◉ Вопрос 14 - 500000 руб.
◉ Вопрос 15 - 1000000 руб.

  Подсказки Участникам разрешается применить три подсказки, которые они могут использовать в любой момент викторины. Каждая из подсказок может быть использована только один раз.
◉ 50/50 - исключает два неправильных ответа из множественного выбора, оставляя участнику только один правильный и один неправильный вариант. Это означает, что у него есть шанс 50/50.
◉ Задать вопрос аудитории - залу задают тот же вопрос, что и участнику, и проводится быстрый опрос, чтобы показать их ответы. На диаграмме показывается явное преимущество определенного варианта, эта подсказка может быть чрезвычайно полезной. Участнику дается возможность согласиться с результатами, полученными от аудитории.
◉ Право на ошибку - участникам разрешается сделать ошибку в ответе на вопрос. При не верном ответе игра не заканчивается.
"""
}
