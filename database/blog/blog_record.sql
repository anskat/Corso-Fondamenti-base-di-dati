/*

Esercizio riassuntivo del corso TSS
Argomento: database

FASE 3: Inserimento record

*/
-- ------------------------------------------------------------------------------------------

/*
-- Di seguito gli INSERT per le tabelle create
-- ATTENZIONE: prima di eseguire lo script verificate che le tabelle siano corrette
-- Per precauzione eseguite un INSERT alla volta e verificate nella finestra di output di Workbench che non ci siano errori
-- NOTA a titolo informativo: il contenuto dei post è scritto in HTML

*/

INSERT INTO `users` VALUES (1,'Giuseppe','Vecchione','vecchione','vecchione@example.com','$2y$10$N7h3EmZKL4L72X2zS3QrUeF5q6J9vYwLW8cDcJ1zTxW1JkLZD8JW','2025-08-05 15:45:28','2025-08-06 12:18:29'),(2,'Marco','Rossi','rossi','rossi@example.com','$2y$10$VjO3D7sM8vW5q2XaN9YbE.9zT1B2rLkC0wP7uH6vY3dF5gN7ZD8JW','2025-08-05 15:45:28','2025-08-06 12:18:09'),(3,'Luca','Verdi','verdi','verdi@example.com','$2y$10$Xp9Qr2S4V6t8W0Y2L3NvE.7zT1B2rLkC0wP7uH6vY3dF5gN7ZD8JW','2025-08-05 15:45:28','2025-08-06 12:18:09'),(4,'Anna','Bianchi','bianchi','bianchi@example.com','$2y$10$Zq1R3T5U7W9Y0A2B4C6D8.1zT1B2rLkC0wP7uH6vY3dF5gN7ZD8JW','2025-08-05 15:45:28','2025-08-06 12:18:09');

INSERT INTO `posts` VALUES
(1,
'Risotto agli asparagi',
'risotto-agli-asparagi',
'Un piatto che profuma di primavera: cremoso, raffinato e sorprendentemente semplice da preparare. Perfetto per una cena romantica o per stupire con eleganza i tuoi ospiti.',
'<p>Vi proponiamo la ricetta di un grande classico, il risotto agli asparagi.</p>
<p>Delicato nel sapore e morbido nelle consistenza è un primo piatto semplice ma raffinato,</p>
<p>che si adatta a molte occasioni, anche le più speciali come una romantica cena a due.</p>
<p>Un vero must della cucina di primavera.&nbsp;</p>
<p>Ingredienti</p>
<ul class="wp-block-list">
<li>500 g di asparagi</li>
<li>350 g di riso Carnaroli</li>
<li>70 g di burro</li>
<li>1/2 cipolla</li>
<li>brodo vegetale caldo</li>
<li>grana padano grattugiato</li>
<li>olio extravergine di oliva</li>
<li>sale</li>
</ul>
<p>Esecuzione</p>
<p>Livello: facile</p>
<p>Tempo di preparazione: 10 min</p>
<p>Tempo di cottura: 30 min – 35 min</p>
<p>Porzioni: 4</p>
<p>Come preparare</p>
<ol class="wp-block-list">
<li>Per realizzare il risotto agli asparagi iniziate a cuocere gli asparagi a vapore, con un pizzico di sale, per una decina di minuti: devono risultare piuttosto croccanti. Tagliate le punte.</li>
<li>Fate sciogliere 15 grammi di burro in una padella, lasciatevi insaporire le punte degli asparagi per 5 minuti e tenetele da parte. Tagliate il resto degli asparagi a rondelle. In una casseruola fate fondere 30 grammi di burro con 2 cucchiai di olio e lasciatevi appassire la cipolla tritata. Unite il riso, fatelo tostare brevemente, quindi aggiungete gli asparagi a rondelle.</li>
<li>Mescolate con un cucchiaio di legno quindi bagnate con un paio di mestoli di brodo ben caldo. Portate a cottura il risotto cuocendolo come di consueto, aggiungendo un mestolo di brodo mano a mano che il precedente è stato assorbito. Al termine della cottura regolate di sale, unite le punte di asparagi e mantecate con il burro rimasto e il formaggio grattugiato.&nbsp;</li>
<li>Mescolate con molta delicatezza e fate riposare coperto per un paio di minuti, servite quindi il risotto agli asparagi ben caldo.</li>
</ol>',
'post',2,'published',NULL,'2025-06-05 15:45:28','2025-06-05 15:45:28'),
(2,
'Frittata di zucchine',
'frittata-di-zucchine',
'Soffice, dorata e irresistibile: la frittata di zucchine conquista tutti, grandi e piccini. Buona calda o fredda, è il piatto salva-cena che non delude mai.',
'<p>La frittata di zucchine è una ricetta classica e semplice da preparare. Un piatto economico a base di pochi e semplici ingredienti: zucchine, uova, farina, olio e sale.</p>
<p>Un secondo che conquista il palato di grandi e piccini e che può essere gustato sia caldo che freddo.</p>
<p>Ingredienti</p>
<ul class="wp-block-list">
<li>5 uova</li>
<li>400 g di zucchine</li>
<li>farina</li>
<li>olio</li>
<li>sale</li>
</ul>
<p>Esecuzione</p>
<p>Livello: facile</p>
<p>Tempo di preparazione: 15 min</p>
<p>Tempo di cottura: 15 min</p>
<p>Tempo di riposo: 1 ora</p>
<p>Porzioni: 4</p>
<p>Come preparare</p>
<ol class="wp-block-list">
<li>Lavate accuratamente le zucchine, asciugatele e tagliate a rondelle; raccoglietele in un passino a rete, salatele e lasciate che perdano un po’ della loro acqua di vegetazione, ci vorrà circa un’ora.</li>
<li>Passate le rondelle di zucchine in qualche cucchiaio di farina; a parte, sbattete le uova aggiungendo un po’ di sale e pepe.</li>
<li>In un tegame scaldate due cucchiai d’olio e insaporitevi le zucchine per alcuni minuti, quindi salate. In una terrina sbattete le uova, salatele con precauzione, tuffatevi le zucchine. In una padella scaldate due cucchiai d’olio, versatevi il composto di uova e zucchine e cuocete la frittata girandola da entrambi i lati.</li>
<li>Quindi rovesciatela sul piatto da portata, dividetela a spicchi e servitela tiepida o fredda.</li>
</ol>',
'post',3,'published',NULL,'2025-06-09 15:45:28','2025-06-09 15:45:28'),
(3,
'Asparagi impanati',
'asparagi-impanati',
'Croccanti fuori e teneri dentro, gli asparagi impanati sono uno sfizio da servire come antipasto o aperitivo. Con un uovo alla coque diventano un piatto completo e sorprendente!',
'<p>Questi asparagi impanati sono un piatto semplice e versatile, ottimo come sfizioso aperitivo ma anche come antipasto.</p>
<p>Se accompagnati con l’uovo alla coque possono diventare un secondo piatto completo e appagante, equilibrato nei sapori e nelle consistenze.</p>
<p>Una ricetta facile e sfiziosa, da provare!</p>
<p>Ingredienti</p>
<ul class="wp-block-list">
<li>250 g di asparagi</li>
<li>2 uova</li>
<li>100 g di pangrattato</li>
<li>sale</li>
<li>pepe</li>
<li>olio extravergine d’oliva</li>
</ul>
<p>Come preparare</p>
<ol class="wp-block-list">
<li>Lavate accuratamente gli asparagi e privarli del gambo. Lasciateli cuocere per circa 5/10 minuti in acqua bollente. Quando saranno completamente raffreddati, passate nell’uovo sbattuto gli asparagi. Aggiungete sale e pepe.</li>
<li>Passate gli asparagi nel pangrattato. Sistemate tutti gli asparagi in una teglia rivestita di carta forno ed irrorate con un po’ di olio. Infornate a 180° per circa 10 minuti.</li>
<li>Dopo la cottura, lasciate raffreddare gli asparagi e se necessario, sistemateli in un piatto con della carta cucina in modo tale che venga assorbito l’olio in eccesso. Nel frattempo preparate l’uovo. Fate bollire in un pentolino dell’acqua, toglietelo dal fuoco quando l’acqua ha raggiunto il bollore e immergete un uovo. Lasciatelo cuocere per circa 3 minuti. Successivamente servite gli asparagi con l’uovo ancora caldo.</li>
</ol>',
'post',4,'published',NULL,'2025-07-05 15:45:28','2025-07-05 15:45:28'),
(4,
'Parmigiana di zucchine',
'parmigiana-di-zucchine',
'Strati golosi di zucchine, pomodoro, ricotta e parmigiano: la parmigiana di zucchine è un trionfo mediterraneo che sa di casa e convivialità.',
'<p>La parmigiana di zucchine è una gustosa ricetta vegetariana ​che può essere servita come secondo o piatto unico.</p>
<p>Gli ingredienti sono semplici ma equilibrati con sapore: zucchine al forno, sugo di pomodoro, parmigiano e una delicata crema di ricotta.</p>
<p>Un piccolo trionfo di sapori mediterranei.</p>
<p>Ingredienti</p>
<ul class="wp-block-list">
<li>7-8 zucchine medie</li>
<li>400 g di ricotta</li>
<li>parmigiano reggiano grattugiato</li>
<li>400 ml di passata di pomodoro</li>
<li>basilico fresco</li>
<li>1 spicchio d’aglio</li>
<li>olio extravergine d’oliva</li>
<li>sale</li>
<li>pepe</li>
</ul>
<p>Esecuzione</p>
<p>Livello: facile</p>
<p>Tempo di preparazione: 20 min</p>
<p>Tempo di cottura: 1h</p>
<p>Porzioni: 4</p>
<p>Come preparare</p>
<ol class="wp-block-list">
<li>Iniziate la preparazione della parmigiana di zucchine spuntando e tagliando a fette le zucchine con una mandolina, nel senso della lunghezza.</li>
<li>Disponetele su una teglia da forno con poco olio e sale e passatele in forno, preriscaldato a 180°, per circa 10-15 minuti, girandole verso metà cottura.</li>
<li>In una casseruola fate insaporire l’olio con lo spicchio d’aglio e aggiungetevi la passata di pomodoro. Salate, pepate e fate restringere per 15 minuti a fiamma dolce.</li>
<li>Preparazione Parmigiana di zucchine – Fase</li>
<li>In una ciotola riunite la ricotta, 1 cucchiaio d’olio, il basilico tritato, un pizzico di sale e una macinata di pepe. Mescolate bene con un cucchiaio fino ad ottenere un composto cremoso ed omogeneo. Velate il fondo di una pirofila con la salsa di pomodoro.</li>
<li>Adagiatevi sopra uno strato omogeneo di zucchine, ricopritelo con un po’ di salsa, qualche cucchiaiata di ricotta e abbondante parmigiano grattugiato</li>
<li>Procedete alternando strati in questo modo e terminando con la sola salsa di pomodoro e il parmigiano. Cuocete nel forno già caldo a 180° per 25-30 minuti. Sfornate e fate assestare la parmigiana di zucchine per qualche minuto prima di servirla.</li>
</ol>',
'post',2,'published',NULL,'2025-07-09 15:45:28','2025-07-09 15:45:28'),
(5,
'Merluzzo gratinato',
'merluzzo-gratinato',
'Un secondo leggero e saporito, con una crosticina dorata e profumata alle erbe. Il merluzzo gratinato è la ricetta perfetta per far amare il pesce a tutti, bambini compresi!',
'<p>Il merluzzo gratinato è un secondo piatto di pesce leggero, gustoso ed economico. Si tratta di filetti di merluzzo al forno con una crosticina croccante aromatizzata alle erbe.</p>
<p>E’ una ricetta facilissima, e veloce da realizzare, di sicura riuscita se si vuol fare mangiare il pesce anche ai bambini o a chi generalmente lo gradisce poco.&nbsp;</p>
<p>Ingredienti</p>
<ul class="wp-block-list">
<li>5 tranci di merluzzo da circa 200 g l’uno</li>
<li>80 g di pangrattato</li>
<li>100 ml di vino bianco</li>
<li>la scorza grattugiata di un limone</li>
<li>1 ciuffetto di prezzemolo</li>
<li>4 foglie di salvia</li>
<li>1 rametto di rosmarino</li>
<li>4 cucchiaio di olio extravergine d’oliva</li>
<li>sale</li>
<li>pepe</li>
</ul>
<p>Esecuzione</p>
<p>Livello: facile</p>
<p>Tempo di preparazione: 15 min</p>
<p>Tempo di cottura: 15 min</p>
<p>Porzioni: 5</p>
<p>Come preparare</p>
<ol class="wp-block-list">
<li>Iniziate la preparazione del merluzzo gratinato emulsionando in una ciotola 2 cucchiai di olio con il vino e il pepe fresco. Nel bicchiere di un mixer mettete le erbe aromatiche e tritatele finemente. Trasferite il trito in una boule con 2 cucchiai d’olio, il pangrattato e la scorza di limone grattugiata.&nbsp;</li>
<li>Mescolate e impanate con cura da entrambi i lati i tranci di merluzzo. Mettete i tranci impanati in una teglia e irrorateli con l’emulsione precedentemente preparata.&nbsp;</li>
<li>Infornateli a 180° per 15 minuti o fino a quando saranno ben dorati in superficie. I tranci di merluzzo gratinato sono pronti per essere serviti.</li>
</ol>',
'post',3,'published',NULL,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(6,
'Carciofi alla Giudia',
'carciofi-alla-giuda',
'Un simbolo della tradizione romana: i carciofi fritti due volte, croccanti come fiori dorati. Un antipasto unico che racchiude storia e sapore in ogni morso.',
'<p>I carciofi alla Giuda sono una ricetta della cucina giudaico-romana. A Roma, nella zona del Ghetto, non c’è ristorante che non li proponga come antipasto, contorno o secondo di verdura. La loro particolarità è quella di essere fritti due volte: ecco come farli a casa!</p>
<p>Ingredienti</p>
<ul class="wp-block-list">
<li>4 carciofi teneri tipo mammole</li>
<li>2 limoni</li>
<li>1 litro e 1/2 di olio di arachidi</li>
<li>sale</li>
<li>pepe</li>
</ul>
<p>Come preparare</p>
<ol class="wp-block-list">
<li>Per fare i carciofi alla giuda, per prima cosa pulite i carciofi togliendo le foglie esterne, più scure e dure, fino ad arrivare a quelle più chiare. Togliete via anche le escrescenze sul gambo, le attaccature delle foglie eliminate e la punta delle foglie rimaste attaccate. A mano a mano riponeteli in una ciotola con acqua e succo di limone. Scolateli e asciugateli con carta assorbente. Scaldate l’olio in una pentola dai bordi alti. Immergete i carciofi nell’olio e friggeteli per circa 10 minuti. Verificate la cottura con una forchetta: dovrà passare facilmente attraverso il cuore del carciofo. Una volta cotti, scolateli e lasciateli raffreddare capovolti su di un piatto, poi aprite le foglie come se fossero dei fiori.</li>
<li>Immergeteli nuovamente nell’olio per un paio di minuti con la parte delle foglie verso il basso ed esercitando una leggera pressione dei carciofi sul fondo della pentola. Scolateli e sistemateli capovolti su di un piatto ricoperto di carta assorbente perché perdano l’olio in eccesso, poi servite i vostri carciofi alla giudia ancora caldi conditi con sale e pepe.</li>
</ol>',
'post',4,'published',NULL,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(7,
'Spaghetti alle vongole veraci',
'spaghetti-alle-vongole',
'Un classico intramontabile della cucina italiana: spaghetti alle vongole veraci, profumati, saporiti e perfetti per portare il mare in tavola in ogni stagione.',
'<p>Una ricetta classica e intramontabile quella degli spaghetti alle vongole veraci, un primo piatto ai frutti di mare semplice e adatto a tutte le stagioni.</p>
<p>Il tempo di preparazione è di trenta minuti circa, ma considerate il necessario tempo di ammollo per eliminare la sabbia.</p>
<p>Ingredienti</p>
<ul class="wp-block-list">
<li>1 kg di vongole veraci</li>
<li>300 g di spaghetti</li>
<li>100 ml di vino bianco</li>
<li>peperoncino</li>
<li>olio</li>
<li>aglio</li>
<li>pepe</li>
<li>sale</li>
</ul>
<p>Esecuzione</p>
<p>Livello: facile</p>
<p>Tempo di preparazione: 30 min</p>
<p>Tempo di cottura: 15 min</p>
<p>Porzioni: 4</p>
<p>Come preparare</p>
<ol class="wp-block-list">
<li>Prima di preparare gli spaghetti alle vongole veraci, fate spurgare per almeno 12 ore le vongole in acqua di mare oppure in acqua fredda e sale. Passato il tempo necessario, scolatele e ripassatele di nuovo sempre con dell’acqua fredda. Picchiettate le conchiglie su un piano per accertarvi che non ci sia più sabbia. Mettete le vongole in una padella con l’aglio e il vino bianco a fuoco vivo, fate evaporare l’alcol, poi sigillate con un coperchio fino a quando le vongole saranno totalmente aperte. Ci vorranno circa 3 minuti. Scolatele e recuperate l’acqua (sughetto) ottenuta che andrete a filtrare e a tenere da parte.</li>
<li>Fate rosolare a fuoco basso l’aglio con poco peperoncino a aggiungete le vongole, l’acqua filtrata in precedenza e insaporite per qualche minuto.</li>
<li>Tritate finemente del prezzemolo. Cuocete gli spaghetti in acqua salata e ritirateli molto al dente per non rischiare che in padella scuociano.</li>
<li>Scolate gli spaghetti e metteteli nella pentola con le vongole, amalgamate per qualche secondo, servite ben caldi con una girata di pepe e prezzemolo.</li>
</ol>',
'post',3,'published',NULL,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(8,
'Roast beef',
'roast-beef',
'Morbido, succoso e cotto alla perfezione: il roast beef è il re del Sunday Roast, ma conquista ogni occasione speciale con il suo fascino senza tempo.',
'<p>Una ricetta classica che nei paesi di tradizione anglosassone viene servita per il cosiddetto Sunday Roast. Seguite la nostra ricetta, aiutatevi con un termometro per ottenere la cottura che desiderate e proponetelo con delle verdure arrosto. Partendo da un taglio di carne pregiato il risultato sarà superbo.&nbsp;</p>
<p>Ingredienti</p>
<ul class="wp-block-list">
<li>800 g di lombata anteriore di manzo</li>
<li>25 g di olio extravergine d’oliva</li>
<li>60 g di zucchero di canna</li>
<li>30 g di sale marino fino</li>
</ul>
<p>Esecuzione</p>
<p>Livello: medio</p>
<p>Tempo di preparazione: 15 min</p>
<p>Tempo di cottura: 20 min – 30 min</p>
<p>Tempo di riposo: 3h e 50 min</p>
<p>Porzioni: 4</p>
<p>Come preparare</p>
<ol class="wp-block-list">
<li>Prima di preparare il roast beef lasciate la carne a temperatura ambiente per almeno tre ore. Mondatela eliminando eventuali fasce di fibre o grasso. Legate la carne da cucina con uno spago. Miscelate sale e zucchero e stendeteli sulla carne in maniera uniforme massaggiando per far assorbire completamente. Lasciate riposare per 20 minuti.</li>
<li>Spennellate a questo punto con olio di oliva. Per una cottura a regola d’arte infilate un termometro a sonda nella carne cruda. Preriscaldate il forno a 250°. Infornate appoggiando la carne direttamente sulla griglia del forno. Cuocete uniformemente girando la carne 3-4 volte fino a quando la sonda avrà raggiunto la temperatura di 52°C al cuore.</li>
<li>Togliete il roast beef dal forno, posizionatelo su una gratella e lasciatelo riposare non coperto per 30 minuti a temperatura ambiente rigirandolo ogni 6-7 minuti. Eliminate lo spago e servite a fette.&nbsp;</li>
</ol>',
'post',2,'published',NULL,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(9,
'Cipolle caramellate',
'cipolle-caramellate',
'Dolci, vellutate e leggermente agrodolci: le cipolle caramellate sono il contorno gourmet che trasforma ogni piatto di carne in una vera esperienza di gusto.',
'<p>Una ricetta semplice, economica e perfetta come contorno agrodolce per accompagnare un secondo piatto di carne. Lessate e poi glassate in padella con burro, zucchero e aceto di vino rosso, queste cipolle caramellate vi conquisteranno con il loro profumo intenso ma delicato e la loro consistenza fondente.</p>
<p>Ingredienti</p>
<ul class="wp-block-list">
<li>3-4 cipolle bianche medie</li>
<li>30 g di burro</li>
<li>3 cucchiai di zucchero semolato</li>
<li>1/2 bicchiere circa di aceto di vino rosso</li>
<li>sale</li>
<li>pepe</li>
</ul>
<p>Esecuzione</p>
<p>Livello: facile</p>
<p>Tempo di preparazione: 15 min</p>
<p>Tempo di cottura: 40 min</p>
<p>Porzioni: 4</p>
<p>Come preparare</p>
<ol class="wp-block-list">
<li>Mondate le cipolle, eliminando le estremità in modo da pareggiarle ed eliminando il primo strato. Tagliatele a metà.</li>
<li>Lessatele in acqua bollente salata per 20 minuti, quindi scolatele delicatamente.</li>
<li>In una padella fate fondere il burro insieme allo zucchero semolato. Unite le cipolle e portatele a cottura, girandole più volte con un cucchiaio.</li>
<li>A mano a mano il fondo di cottura diventerà caramellato, asciugherà e andrà pertanto sfumato di tanto in tanto con l’aceto di vino rosso. Quando sarà diventato denso e sciropposo rigiratevi le cipolle. Servite le cipolle caramellate aggiustando di sale e pepe a piacere.</li>
</ol>',
'post',3,'published',NULL,'2025-08-05 15:45:28','2025-08-05 15:45:28');


INSERT INTO `comments` VALUES (1,1,2,NULL,NULL,NULL,'Ricetta perfetta, grazie!','approved','2025-08-05 15:45:28','2025-08-05 15:45:28'),(2,1,NULL,NULL,'Guest','guest@example.com','Posso sostituire l\'aglio con qualcos\'altro?','approved','2025-08-05 15:45:28','2025-08-05 15:45:28'),(3,1,3,2,NULL,NULL,'Prova con lo scalogno, viene buono anche così!','approved','2025-08-05 15:45:28','2025-08-05 15:45:28'),(4,2,4,NULL,NULL,NULL,'La cotoletta era croccantissima!','approved','2025-08-05 15:45:28','2025-08-05 15:45:28'),(5,3,NULL,NULL,'FoodLover','foodie@example.com','Che verdure consigliate?','pending','2025-08-05 15:45:28','2025-08-05 15:45:28');

INSERT INTO `terms` VALUES
(1,'Primi piatti','primi-piatti','Ricette di primi','category',NULL,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(2,'Secondi piatti','secondi-piatti','Ricette di secondi','category',NULL,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(3,'Contorni','contorni','Ricette di contorni','category',NULL,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(4,'asparagi','asparagi',NULL,'tag',NULL,'2025-08-05 15:45:28','2025-08-06 09:12:50'),
(5,'risotto','risotto',NULL,'tag',NULL,'2025-08-06 09:55:37','2025-08-06 09:55:37'),
(6,'frittata','frittata',NULL,'tag',NULL,'2025-08-06 13:48:23','2025-08-06 13:48:23'),
(7,'uova','uova',NULL,'tag',NULL,'2025-08-06 16:17:04','2025-08-06 16:19:08'),
(8,'zucchine','zucchine',NULL,'tag',NULL,'2025-08-06 16:17:04','2025-08-06 16:19:08'),
(9,'ricotta','ricotta',NULL,'tag',NULL,'2025-08-06 16:17:04','2025-08-06 16:19:08'),
(10,'limone','limone',NULL,'tag',NULL,'2025-08-06 16:17:04','2025-08-06 16:19:08'),
(11,'merluzzo','merluzzo',NULL,'tag',NULL,'2025-08-06 16:17:04','2025-08-06 16:19:08'),
(12,'vino','vino',NULL,'tag',NULL,'2025-08-06 16:17:04','2025-08-06 16:19:08'),
(13,'carciofi','carciofi',NULL,'tag',NULL,'2025-08-06 16:17:04','2025-08-06 16:19:08'),
(14,'spaghetti','spaghetti',NULL,'tag',NULL,'2025-08-06 16:17:04','2025-08-06 16:19:08'),
(15,'vongole','vongole',NULL,'tag',NULL,'2025-08-06 16:17:04','2025-08-06 16:19:08'),
(16,'carne','carne',NULL,'tag',NULL,'2025-08-06 16:17:04','2025-08-06 16:19:08'),
(17,'forno','forno',NULL,'tag',NULL,'2025-08-06 16:17:04','2025-08-06 16:19:08'),
(18,'cipolle','cipolle',NULL,'tag',NULL,'2025-08-06 16:17:04','2025-08-06 16:19:08');

INSERT INTO `term_relationships` VALUES 
(1,1,1,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(2,2,2,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(3,3,3,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(4,1,4,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(5,2,5,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(6,3,6,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(7,1,7,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(8,2,8,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(9,3,9,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(10,4,1,'2025-08-05 15:45:28','2025-08-05 15:45:28'),
(11,5,1,'2025-08-06 09:57:39','2025-08-06 09:57:39'),
(12,6,2,'2025-08-06 13:48:55','2025-08-06 13:48:55'),
(13,7,2,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(14,8,2,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(15,4,3,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(16,7,3,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(17,9,4,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(18,8,4,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(19,10,5,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(20,11,5,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(21,12,5,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(22,13,6,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(23,10,6,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(24,14,7,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(25,15,7,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(26,16,8,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(27,17,8,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(28,18,9,'2025-08-06 16:17:28','2025-08-06 16:17:28'),
(29,12,9,'2025-08-06 16:17:28','2025-08-06 16:17:28');