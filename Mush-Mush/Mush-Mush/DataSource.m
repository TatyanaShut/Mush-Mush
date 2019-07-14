//
//  DataSourse.m
//  Mush-Mush
//
//  Created by Tatyana Shut on 14.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlArray = [[NSArray alloc] init];
        self.nameMushroom = [[NSArray alloc]init];
        self.descriptionMushroom = [[NSArray alloc]init];
        
        self.urlArray =  @[@"http://ya-gribnik.ru/images/beluy-grib/1.jpg", @"http://ya-gribnik.ru/images/lisichki/2.jpg",@"http://ya-gribnik.ru/images/maslenok/3.jpg", @"http://ya-gribnik.ru/images/syroezhka/3.jpg",@"http://ya-gribnik.ru/images/trufel/1.jpg", @"http://ya-gribnik.ru/images/shyitake/2.jpg", @"http://ya-gribnik.ru/images/porhovka/2.jpg", @"http://ya-gribnik.ru/images/podberezovik/3.jpg",@"http://ya-gribnik.ru/images/boletin-bolotnuy/3.jpg", @"http://ya-gribnik.ru/images/polybeluy-grib/2.jpg",@"http://ya-gribnik.ru/images/sparassis-kurchavuy/2.jpg",@"http://ya-gribnik.ru/images/cezarskiy-grib/3.jpg",@"http://ya-gribnik.ru/images/zontik-pestruy/8.jpg",@"http://ya-gribnik.ru/images/golovach/1.jpg",@"http://ya-gribnik.ru/images/plytey-lvino-zheltuy/1.jpg",@"http://ya-gribnik.ru/images/pecyca/5.jpg", @"http://ya-gribnik.ru/images/beluy-stepnoy-grib/1.jpg",@"http://ya-gribnik.ru/images/ezhevik-zheltiy/5.jpg",@"http://ya-gribnik.ru/images/cheshyichatka-zolotistaya/4.jpg",@"http://ya-gribnik.ru/images/paytinnik-fioletoviy/2.jpg",@"http://ya-gribnik.ru/images/polskiy-grib/2.jpg",@"http://ya-gribnik.ru/images/podosinovik/6.jpg", @"http://ya-gribnik.ru/images/opyata/4.jpg",@"http://ya-gribnik.ru/images/gruzd/5.jpg",@"http://ya-gribnik.ru/images/shampinony/2.jpg"];
        
        
        self.nameMushroom = @[@"Белый гриб",@"Лисички",@"Маслёнок",@"Сыроежка",@"Трюфель",@"Шиитаке",@"Порховка",@"Подберезовик",@"Болетин болотный",@"Полубелый гриб",@"Спарассис курчавый",@"Цезарский гриб",@"Зонтик пёстрый",@"Головач",@"Плютей львино-жёлтый",@"Пеццица",@"Белый степной гриб",@"Ежевик желтый",@"Чешуйчатка золотистая",@"Паутинник фиолетовый",@"Польский гриб",@"Подосиновик",@"Опята",@"Груздь",@"Шампиньоны"];
        
        
        self.descriptionMushroom = @[@"Шляпка зрелого белого гриба достигает в диаметре до 30 см (в некоторых случаях встречается экземпляры, имеющие шляпку 50 см). Форма выпуклая, плоско-выпуклая, распростертая в зависимости от возраста гриба. Поверхность шляпки слегка морщинистая, гладкая, тонковойлочная, у некоторых представителей – волокнисто-чешуйчатая.", @"Лисичка обыкновенная (настоящая) отличается шляпконожечным плодовым телом, где шляпка и ножка сросшиеся, не имеющие четкого перехода. Цвет шляпки варьируется от светло-желтого до желто-оранжевого. В диаметре от 2 до 12 см, с волнистым краем неправильной формы. Иногда встречается лисички, шляпки которых имеют вогнуто-распростертую, выпуклую или вдавленную, плоскую форму.",@"Масленок – это общее название грибов из рода трубчатых грибов, относящихся к семейству Болетовые.Трубчатый слой, сросшийся с ножкой, желтого цвета. Ножка масленка обыкновенного цилиндрическая, достигающая 11 см в высоту и 3 см в диаметре. Ножка сплошная, с хорошо выраженными продольными волокнами и белым покрывалом у шляпки.",@"Сыроежка - наиболее распространенный гриб, относящийся к семейству сыроежковые.",@"Сыроежка волнистая – съедобный представитель сыроежковых, произрастающий в лиственных лесах. Отличается пурпурной шляпкой с вдавленным центром. Иногда на шляпке присутствуют желтые пятнышки. Ножка у волнистой сыроежки короткая, булавовидной формы, белого (кремового) оттенков. Мякоть белая, едкая на вкус.",@"Род трюфелевые насчитывают около 100 видов, характерным признаком которых является расположенное под землей плодовое тело. Мицелий трюфеля состоит из 3-7 плодовых тел, собранных в кружок. По мере созревания грибы приподнимают почву, образуя трюфельники. Полное развитие происходит в течение 3-4 месяцев, созревая от лета до зимы, не теряя вкусовых свойств даже при заморозках. Наиболее ценным видом считается настоящий черный трюфель (перигорский).",@"Грибы шиитаке(императорский гриб сиитаке) –традиционный гриб в странах Востока и Азии. Шляпка гриба достигает 20 см в диаметре, выпуклая, полусферическая, имеющая небольшие чешуйки. По мере созревания может растрескиваться. На ощупь бархатистая, сухая. По мере роста становится более плоской. Края ровные, у зрелых грибов немного согнутые и более тонкие, волнистые. Цвет шляпки варьируется от темно-коричневой до светлых кофейных оттенков у зрелых грибов.", @"Порховка относится к виду дождевых грибов, отсюда и плодовое тело и способ размножения. Тело имеет шаровидную или яйцеобразную форму, в диаметре достигает от трех, до шести сантиметров. Порховки, которые вступили в конечный период развития - начинают желтеть, после чего очень быстро становятся черными. Ножки у них нет, белая мякоть с достаточно приятным запахом и еле заметным вкусом.",@"Подберезовик – гриб,относящийся к роду Обабковые, семейству Болетовые",@"Подберезовик обыкновенный отличается красно-бурой шляпкой с гладкой, слегка слизистой поверхностью. В сухую погоду поверхность шляпки блестит. У молодых грибов она имеет форму выпуклой полусферы, у зрелых – подушковидная. Диаметр достигать может 15 см. Под шляпкой у молодых грибов поры окрашены в беловато-кремовые оттенки, у зрелых – серовато-охряные.", @"Болетин болотный, также имеет название решетник болотный, масленок ложный, иванчик. Шляпка этого гриба достигает десяти сантиметров в диаметре, имеет подушковидную форму с бугорком посредине. Структура шляпки войлочно-чешуйчатая, сухая, у молодых грибов она очень яркая, бордового или пурпурно-красного цвета. Со временем она приобретает желтоватый оттенок",@"Полубелый гриб называют также желтым боровиком.Шляпка этого гриба достигает от пяти до 20 сантиметров в диаметре. У молодых грибов она подушковидная, поверхность бархатистая, с возрастом становится гладкой, имеет рыжеватый или светло-серый с оливковым оттенком цвет. Трубочки этого гриба свободно размещены, имеют золотисто-желтый оттенок, со временем приобретают зеленовато-желтый оттенок.",@"Гриб спарассис курчавый имеет огромное количество названий в народе - это и грибная капуста, и гриб-баран, и заячья капуста и прочее. Этот гриб вполне съедобный. Он состоит из ножки, которая глубоко уходит в землю и большого количества извивистых ветвей, которые образуют круглое тело, похожее на капусту. Поэтому его так и прозвали. Ножка этого гриба короткая, достаточно толстая, в диаметре может достигать пяти сантиметров. В длину она может достигать от двенадцати до пятнадцати сантиметров",@"Шляпка цезарского гриба имеет яркую желто-красную или оранжевую окраску, дорастает до 20 сантиметров в диаметре. У молодых грибов она выпуклой формы, с возрастом же становится более распростертой. Края шляпки рубчатые. Спороносные пластинки, обычно оранжевые или золотистые, с незаметной бахромой, которая расположена ближе к шляпке. Мякоть гриба желтого цвета в шляпке, белая с плавным переходом в ножке.",@"Гриб зонтик пестрый очень распространен и встретить его можно в лесах, на лугах, полях, даже на своем огороде",@"Зонтик, достаточно крупный гриб, размер шляпки может достигать в диаметре до двадцати шести сантиметров. Начиная с самого начала развития она меняет свою форму. У молодых грибов она яйцевидная, затем колокольчатая, у взрослых же грибов она зонтиковидная, с бугром, от чего гриб и получил свое название.",@"Многие люди после того, как первый раз увидят гриб головач, еще долго будут восхищаться этим чудом природы. Этот гриб очень выгодно смотрится на фоне своих родственников дождевых грибов за счет своей формы, а также размеров. Огромное плодовое тело белого цвета, булаво- или кеглевидной формы, не совсем может вписаться в общую картину нашего представления грибов. Этот гриб может достигать двадцати сантиметров в высоту. Мякоть этого гриба рыхлая, белого цвета.", @"Плютей львино-желтый можно довольно часто встретить в лиственных лесах.Он может произрастать в смешанных и хвойных лес ах тоже. Этот гриб любит березу, а также гниющие пни, древесину, погруженную в почву, а также валежники. Наткнуться на него можно начиная с середины июня до середины сентября. Больше всего его можно собрать в июле. Очень редко этот гриб можно встретить поодиночке, в основном растет группами.",@"Гриб пецица не имеет как таковой шляпки, он обладает сидячим плодовым телом.",@"У молодого гриба оно пузырчатой формы, затем, с возрастом оно раскрывается, а к старости приобретает форму блюдца с немного подвернутыми кверху краями. В диаметре может достигать от четырех до десяти сантиметров. Поверхность коричневого цвета, гладкая, в сырую погоду блестящего цвета.",@"По популярности белый степной гриб можно сравнить с подгруздком белым.Шляпка этого гриба может быть от двух до пятнадцати сантиметров, иногда она может достигать и тридцати. Пока гриб молодой она имеет полушаровидную форму, затем она становится плоско-распростертой, или вогнутой, зачастую неправильной формы. Ее структура может быть как гладкой, так и чешуйчатой, слегка трещиноватая.",@"Шляпка этого гриба может достигать пятнадцати сантиметров в диаметре. Она представляет собой мясистую, плотную поверхность неправильной формы. У молодых грибов она слабовыпуклая с загнутыми краями вниз. С возрастом шляпка становится плоской или с вогнутой серединой, края становятся волнистыми, напоминает лисички.Окраска может быть от розовато-желтой до светло-ореховой.", @"Шляпка у чешуйчатки золотистой может достигать двадцати сантиметров в диаметре. Молодой гриб отличается своим ярко-золотистым цветом, со временем он может выцвести до рыжего. На шляпке можно рассмотреть темные чешуйки, из-за чего гриб и получил сове название. Ножка гриба тонкая, в диаметре всего лишь пару сантиметров. В длину же она может достигать и пятнадцати",@"Этот гриб имеет крупную толстомясистую шляпку. У молодых грибов она колоколовидная или полушаровидная, с возрастом раскрывается до полураспрастертой. Имеет насыщенный фиолетовый цвет. Поверхность шляпки бархатистая, сухая. Мякоть шляпки рыхлая и толстая. Окрашена от ярко-фиолетового до беловатого оттенка. Имеет еле заметный запах",@"Довольно распространённый гриб, относящийся к семейству болетовых, роду моховиков. Шляпка польского гриба обычно достигает 12-15 см, имея подушковидную, округлую форму. Молодые грибы отличаются шляпкой с завернутыми книзу краями, зрелые имеют завернутые кверху края. По мере созревания шляпка становится более плоской",@"Подосиновик– это общее название грибов, относящихся к роду Лекцинум. Практически все подосиновики имеют красную шляпку, коренастую ножку и плотную мякоть. Подосиновики съедобные, приятные на вкус грибы, относящиеся ко второй категории. Различают несколько видов подосиновиков, но наиболее часто встречаются подосиновик красный, желто-бурый, дубовый, еловый, сосновый.",@"Название «опёнок» или «опята» - народное название, объединяющее различные семейства и роды грибов. Гриб имеет шляпку, диаметром от2 до 10 см, плоскую, от желтого до оранжево-коричневого цвета. Молодые грибы, шляпка которых выпуклая, края светлее, чем серединка. Ножка трубчатая и плотная бархатисто-коричневого цвета, длина которой достигает 7 см. Мякоть опенка зимнего тонкая. Пластинки редкие, приросшие",@" Шляпка вырастает до 20 см в диаметре. Груздь черный имеет воронковидную шляпку, края которой завернуты. Кожица при большой влажности становится клейкой. Цвет может меняться от темно-оливкового до темно-бурого. В центре обычно цвет темнее, чем у краев. Мякоть ломкая, плотная, окрашивается в серый цвет на разломе. Сок белый, обильный с едким привкусом.",@" Имеет округлую форму с загнутыми краями и остатками покрывала. Поверхность гладкая, иногда глянцевая, белого цвета. Остальные разновидности могут быть окрашены в кремовый или коричневый оттенки.По мере созревания шляпка становится более плоской с разрывами по краям. Мякоть плотная, на изломе приобретающая розовый оттенок. Молодые грибы шампиньоны имеют розовые пластинки, которые по мере созревания приобретают темно-коричневый или фиолетовый оттенок."];
    }
    
    return self;
}

@end
