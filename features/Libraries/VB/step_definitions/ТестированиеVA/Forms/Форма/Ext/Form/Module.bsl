﻿//начало текста модуля
&НаКлиенте
Перем Ванесса;

&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;


&НаКлиенте
Функция ДобавитьШагВМассивТестов(МассивТестов,Снипет,ИмяПроцедуры,ПредставлениеТеста = Неопределено,Транзакция = Неопределено,Параметр = Неопределено)
	Структура = Новый Структура;
	Структура.Вставить("Снипет",Снипет);
	Структура.Вставить("ИмяПроцедуры",ИмяПроцедуры);
	Структура.Вставить("ИмяПроцедуры",ИмяПроцедуры);
	Структура.Вставить("ПредставлениеТеста",ПредставлениеТеста);
	Структура.Вставить("Транзакция",Транзакция);
	Структура.Вставить("Параметр",Параметр);
	МассивТестов.Добавить(Структура);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВыполняюМетодШагСТекстомИОнНеВызываетИсключение(ТабПарам)","ЯВыполняюМетодШагСТекстомИОнНеВызываетИсключение","И я выполняю метод шаг с текстом и он не вызывает исключение","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВыполняюМетодШагСТекстомИОнВызываетИсключение(ТабПарам)","ЯВыполняюМетодШагСТекстомИОнВызываетИсключение","И я выполняю метод шаг с текстом и он вызывает исключение","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПомещаюВБуферОбменаСтроку(Парам01)","ЯПомещаюВБуферОбменаСтроку","И я помещаю в буфер обмена строку 'Нужная строка'","Помещает строку в буфер обмена.","Прочее.Буфер обмена");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВФайлеИнструкцииНетСтроки(Парам01,Парам02)","ВФайлеИнструкцииНетСтроки","И в Файле инструкции ""Instr_ФичаДляПроверкиОтчетаHTML.HTML"" нет строки  ""я выполняю простой шаг контекста""","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВФайлеИнструкцииЕстьСтрока(Парам01,Парам02)","ВФайлеИнструкцииЕстьСтрока","И в Файле инструкции ""Instr_ФичаДляПроверкиОтчетаHTML.HTML"" есть строка ""Другой текст первого шага""","","");
	
	Возврат ВсеТесты;
КонецФункции

&НаКлиенте
Процедура ПередНачаломСценария() Экспорт
КонецПроцедуры

&НаКлиенте
Процедура ПередОкончаниемСценария() Экспорт
	//безусловное закрытие формы если она осталась
	Попытка
	    ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;
		ОткрытаяФормаVanessaBehavoir.Закрыть();
	Исключение
		
	КонецПопытки;
КонецПроцедуры




&НаКлиенте
//И я выполняю метод шаг с текстом и он не вызывает исключение
//@ЯВыполняюМетодШагСТекстомИОнНеВызываетИсключение(ТабПарам)
Процедура ЯВыполняюМетодШагСТекстомИОнНеВызываетИсключение(ТабПарам) Экспорт
	Стр = "";
	Для Каждого СтрокаТабПарам Из ТабПарам Цикл
		Стр = Стр + СтрокаТабПарам.Кол1 + Символы.ПС;
	КонецЦикла;	 
	
	Попытка
		Ванесса.Шаг(Стр);
	Исключение
		ТекстСообщения = "При выполнении Ванесса.Шаг() было вызвано исключение, хотя его не должно было быть. %1 %2";
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Символы.ПС + Стр);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",Символы.ПС + ОписаниеОшибки());
		ВызватьИсключение ТекстСообщения;
	КонецПопытки;
КонецПроцедуры

&НаКлиенте
//И я выполняю метод шаг с текстом и он вызывает исключение
//@ЯВыполняюМетодШагСТекстомИОнВызываетИсключение(ТабПарам)
Процедура ЯВыполняюМетодШагСТекстомИОнВызываетИсключение(ТабПарам) Экспорт
	Стр = "";
	Для Каждого СтрокаТабПарам Из ТабПарам Цикл
		Стр = Стр + СтрокаТабПарам.Кол1 + Символы.ПС;
	КонецЦикла;	 
	
	БылоИсключение = Ложь;
	Попытка
		Ванесса.Шаг(Стр);
	Исключение
		БылоИсключение = Истина;
	КонецПопытки;
	
	Если НЕ БылоИсключение Тогда
		ТекстСообщения = "При выполнении Ванесса.Шаг() было вызвано исключение, хотя его не должно было быть. %1 %2";
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Символы.ПС + Стр);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",Символы.ПС + ОписаниеОшибки());
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
//И я помещаю в буфер обмена строку 'Вывод произвольной информации в лог с помощью шага'
//@ЯПомещаюВБуферОбменаСтроку(Парам01)
Процедура ЯПомещаюВБуферОбменаСтроку(Знач Стр) Экспорт
	Стр = Ванесса.ПолучитьКорректныйТекстДляВставкиВПоле(Стр);
	//Стр = Ванесса.ПолучитьЗначениеИзКонтекстаЕслиЭтоВозможно(Стр);
	
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("txt");
	ЗТ = Новый ЗаписьТекста(ИмяВременногоФайла,"UTF-8",,Истина); 
	ЗТ.Записать(Стр); 
	ЗТ.Закрыть();
	 
	СтрокаКоманды = "clip < ""%1""";
	СтрокаКоманды = СтрЗаменить(СтрокаКоманды,"%1",ИмяВременногоФайла);
	Ванесса.ВыполнитьКомандуОСБезПоказаЧерногоОкна(СтрокаКоманды);
КонецПроцедуры

&НаКлиенте
//И в Файле инструкции "Instr_ФичаДляПроверкиОтчетаHTML.HTML" нет строки "я выполняю простой шаг контекста"
//@ВФайлеИнструкцииНетСтроки(Парам01,Парам02)
Процедура ВФайлеИнструкцииНетСтроки(ИмяФайла,СтрокаПоиска) Экспорт
	Если Контекст.Свойство("КаталогHTML") Тогда
		ИмяФайла = Контекст.КаталогHTML + "\" + ИмяФайла;
	ИначеЕсли Контекст.Свойство("КаталогMarkdown") Тогда	
		ИмяФайла = Контекст.КаталогMarkdown + "\" + ИмяФайла;
	Иначе
		ВызватьИсключение "Не смог определить файл для проверки.";
	КонецЕсли;	 
	
	Текст = Новый ЧтениеТекста;
	Текст.Открыть(ИмяФайла,"UTF-8");
	
	Пока Истина Цикл
		Стр = Текст.ПрочитатьСтроку();
		Если Стр = Неопределено Тогда
			Прервать;
		КонецЕсли;	 
		
		Поз = Найти(Стр,СтрокаПоиска);
		Если Поз > 0 Тогда
			ТекстСообщения = "В файле <%1> найдена строка <%2>";
			ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",ИмяФайла);
			ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",СтрокаПоиска);
			ВызватьИсключение ТекстСообщения;
		КонецЕсли;	 
	КонецЦикла;	
	
	Текст.Закрыть();
	
КонецПроцедуры

&НаКлиенте
//И в Файле инструкции "Instr_ФичаДляПроверкиОтчетаHTML.HTML" есть строка "Другой текст первого шага"
//@ВФайлеИнструкцииЕстьСтрока(Парам01,Парам02)
Процедура ВФайлеИнструкцииЕстьСтрока(ИмяФайла,СтрокаПоиска) Экспорт
	Если Контекст.Свойство("КаталогHTML") Тогда
		ИмяФайла = Контекст.КаталогHTML + "\" + ИмяФайла;
	ИначеЕсли Контекст.Свойство("КаталогMarkdown") Тогда	
		ИмяФайла = Контекст.КаталогMarkdown + "\" + ИмяФайла;
	Иначе
		ВызватьИсключение "Не смог определить файл для проверки.";
	КонецЕсли;	 
	
	Текст = Новый ЧтениеТекста;
	Текст.Открыть(ИмяФайла,"UTF-8");
	
	Стр = Текст.Прочитать();
	Поз = Найти(Стр,СтрокаПоиска);
	Если Поз = 0 Тогда
		ТекстСообщения = "В файле <%1> не найдена строка <%2>";
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",ИмяФайла);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",СтрокаПоиска);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
	
	Текст.Закрыть();
КонецПроцедуры
