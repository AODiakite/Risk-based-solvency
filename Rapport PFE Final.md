

UNIVERSITÉ CADI AYYAD
FACULTÉ DES SCIENCES ET TECHNIQUES
INGÉNIERIE EN FINANCE ET ACTUARIAT

**Mémoire de Projet de fin d’études**

En vue de l’obtention du :

**DIPLÔME D’INGÉNIEUR D’ÉTAT**

**Solvabilité Basée sur les Risques (SBR), Application de calcul des Provisions Prudentielles et du Capital de Solvabilité Requis en assurance vie et non-vie**

**Présenté par :**

**DIAKITÉ Abdoul Oudouss
ETTADLAOUI Othmane**

**Encadré par :**

**Mme. AKDIM Khadija (FSTG)
M. BELFADLI Rachid (FSTG)
M. KHIRAOUI Abdelkrim (ARM CONSULTANTS)**

**Soutenu le 5 Juillet 2023**

**Devant le jury composé de :**

`               `**Mme. AKDIM Khadija                                        Faculté des Sciences et Techniques
`               `M. BELFADLI Rachid                                           Faculté des Sciences et Techniques**

`               `**M. DAAFI Boubker                                              Faculté des Sciences et Techniques**

`               `**M. ELBOUKFAOUI My Youssef                         Faculté des Sciences et Techniques** 

**Anneé universitaire 2022-2023**
**

\*

114*

**





**Remerciements** :

*Avant tout, nous remercions Allah le tout puissant pour les grâces qu’il ne cesse de nous accorder.*

*Nous adressons nos plus sincères remerciements à M.* **KHIRAOUI Abdelkrim,** *Président et Fondateur de **A.R.M CONSULTANTS**, pour nous avoir donné l’opportunité de réaliser notre stage de fin d’études au sein de son cabinet.*

*Nous tenons également à remercier M.* **LOTFI Youness***, Actuaire consultant au sein d’A.R.M CONSULTANTS pour sa disponibilité, ses précieux conseils et remarques très enrichissantes tout au long de notre stage.*

*Nos remerciements vont également à nos respectueux professeurs Mme.* **AKDIM Khadija** *et M.* **BELFADLI Rachid***, pour avoir accepté de nous encadrer lors de cette étape cruciale de notre carrière. Nous leurs remercions aussi pour leur disponibilité et leurs précieuses directives qui nous ont permis de terminer ce travail.* 

*Nous souhaitons exprimer nos sincères remerciements et gratitude à tous nos enseignants au sein de la Faculté des Sciences et Techniques de Marrakech pour leur effort tout au long de notre formation.*












**Solvabilité Basée sur les Risques (SBR), Application de calcul des Provisions Prudentielles et du Capital de Solvabilité Requis en assurance vie et non-vie**

*DIAKITE Abdoul Oudouss, ETTADLAOUI Othmane
(*lien du projet : *https://github.com/AODiakite/Risk-based-solvency)*




# <a name="organisme-daccueil"></a>**Table des matières**

[Organisme d’accueil	6******](#_toc138675049)***

[Liste des abréviations	7******](#_toc138675050)

[Liste des figures	8******](#_toc138675051)

[Liste des tables	9******](#_toc138675052)

[Introduction	10******](#_toc138675053)

[*1.*	CHAPITRE I : Cadre réglementaire Marocain	11******](#_toc138675054)

[*1.1 Cadre réglementaire Marocain*	11****](#_toc138675055)

[*1.2 Piliers 1: Exigences quantitatives*	13****](#_toc138675056)

[2. CHAPITRE II : Construction de la courbe des taux	18******](#_toc138675057)

[*2.1 La construction de la courbe des taux zéro-coupon*	18****](#_toc138675058)

[***Transformation des taux monétaires en taux actuariels***	19](#_toc138675059)

[***Interpolation linéaire de la courbe des taux actuariels***	20](#_toc138675060)

[***La méthode de Bootstrap***	21](#_toc138675061)

[***Extrapolation de la courbe des taux zéro-coupon : Méthode de Smith-Wilson***	23](#_toc138675062)

[3. CHAPITRE III : Valorisation de l’actif	26******](#_toc138675063)

[*3.1 Directives de l’ACAPS*	26****](#_toc138675064)

[*3.2 Modélisation du prix des actions*	26****](#_toc138675065)

[***Modèle de Black-Scholes***	27](#_toc138675066)

[***Réseaux de neurones récurrents***	29](#_toc138675067)

[4. CHAPITRE IV : Valorisation des provisions techniques prudentielles	34******](#_toc138675068)

[*4.1 Généralité*	34****](#_toc138675069)

[*4.2 Opérations d’assurance vie, décès ou capitalisation*	35****](#_toc138675070)

[***Meilleure estimations des engagements (BEeng)***	35](#_toc138675071)

[***Meilleure estimation des frais de gestions (BEFG)***	38](#_toc138675072)

[*4.3 Rentes découlant des opérations non-vie*	39****](#_toc138675073)

[*4.4 Opérations d’assurance non vie hors rentes*	39****](#_toc138675074)

[***La meilleure estimation des engagements***	40](#_toc138675075)

[***La meilleure estimation des frais de gestion***	47](#_toc138675076)

[*4.5 Marge de risque*	48****](#_toc138675077)

[5. CHAPITRE V : Part des cessionnaires	49******](#_toc138675078)

[*5.1 Part des cessionnaires dans les provisions techniques prudentielles*	49****](#_toc138675079)

[*5.2 La meilleure estimation des engagements cédés (BEC)*	49****](#_toc138675080)

[***Les opérations d’assurance vie, décès ou de capitalisation***	49](#_toc138675081)

[***Les opérations non-vie***	50](#_toc138675082)

[*5.3 L’ajustement pour défaut de contrepartie*	52****](#_toc138675083)

[6. CHAPITRE VI : Capital de Solvabilité Requis	53******](#_toc138675084)

[*6.1 Définition générale*	53****](#_toc138675085)

[*6.2 Le capital de solvabilité requis de base (CSRB)*	55****](#_toc138675086)

[***Exigence de capital relative au risque de marché (CSRM)***	55](#_toc138675087)

[***Exigence de capital relative au risque de contrepartie (CSRCp)***	59](#_toc138675088)

[***Exigence de capital relative au risque de concentration (CSRCt)***	62](#_toc138675089)

[***Exigence de capital relative au risque de souscription vie (CSRSV)***	63](#_toc138675090)

[***Exigence de capital relative au risque de souscription non vie (CSRSNV)***	67](#_toc138675091)

[***Exigence de capital relative au risque opérationnel (CSRO)***	69](#_toc138675092)

[***Ajustement du capital de solvabilité requis***	69](#_toc138675093)

[7. CHAPITRE VII : Application numérique de la Solvabilité Basée sur les Risque	71******](#_toc138675094)

[*7.1 Modèle LSTM appliqué au cours de l’indice MASI*	71****](#_toc138675095)

[*7.2 Application de calcul des CSR*	73****](#_toc138675096)

[***Navigation dans le code source***	75](#_toc138675097)

[***Paramètres***	75](#_toc138675098)

[***Courbe des taux***	77](#_toc138675099)

[***Opérations d’assurance non-vie hors rente***	80](#_toc138675100)

[***Opérations d’assurance vie***	89](#_toc138675101)

[***Part des cessionnaires***	92](#_toc138675102)

[***Capital de solvabilité requis***	93](#_toc138675103)

[Conclusion	95******](#_toc138675104)

[ANNEXE N°1 : Code source du modèle LSTM	98******](#_toc138675105)

[ANNEXE N°2 : CORRESPONDANCE ENTRE ECHELLE DE NOTATION ET PROBABILITE DE DEFAUT	100******](#_toc138675106)

[*Échelles de notation*	100****](#_toc138675107)

[*Probabilités de défaut :*	101****](#_toc138675108)


# <a name="_toc138675049"></a>***Organisme d’accueil***
Créée en 1996, **A.R.M CONSULTANTS** est le premier cabinet d’actuaires conseils indépendants au Maroc, en Afrique francophone et dans la région MENA, spécialisé dans l’Actuariat, la gestion des risques et l’ingénierie des assurances. Son capital est détenu à 100% par ses associés, ce qui assure au Cabinet une complète indépendance de tout organisme assureur. La présence d’A.R.M CONSULTANTS, qui regroupe des actuaires consultants de haut niveau, disposant d’une formation supérieure pluridisciplinaires et ayant une longue expérience dans les différents domaines du Risk-Management, de l’assurance et de la prévoyance sociale tant en France qu’au Maroc, présente une réelle opportunité pour :

- Les institutions financières qui souhaitent innover et maîtriser leurs risques, pour devenir leaders dans les domaines de l’assurance, de la bancassurance, de la réassurance, de la prévoyance sociale, de la retraite ou du crédit bancaire.
- Les entreprises et les établissements publics, qui souhaitent optimiser leurs performances en matière de gestion de leurs risques, de leurs assurances et de leurs engagements sociaux.
- Les administrations qui cherchent à élaborer des études actuarielles pour améliorer les systèmes existants de couvertures sociales ou mettre en place de nouveaux régimes de prévoyance sociale.

**A.R.M CONSULTANTS** s’est dotée d’équipes soudées et complémentaires, organisées autour de deux pôles distincts (Institutionnels et Corporate) qui lui permet de couvrir l’ensemble des spécificités actuarielles. Cette richesse, diversité et complémentarité des métiers permet à A.R.M CONSULTANTS de suivre en permanence l’ensemble des évolutions actuarielles et réglementaires. A.R.M CONSULTANTS a su développer et affirmer son savoir-faire et son expertise grâce aux compétences et expériences de ses consultants, à sa spécialisation dans les domaines pointus de l’actuariat et du Risk-Management, et à son approche originale parfaitement adaptée au contexte Marocain et régional, basée sur un conseil extérieur qui est :

- Innovateur,
- Indépendant.
- International, par le biais de son partenariat avec des sociétés similaires de renommée internationale.



# <a name="_toc138675050"></a>***Liste des abréviations***

|<a name="liste-des-abréviations"></a>**Abréviation**|**Désignation**|**Abréviation**|**Désignation**|
| :- | :- | :- | :- |
|Adj|Ajustement pour défaut de contrepartie|FGU|Frais de gestion unitaire|
|AT|Accident de travail|FRFP|Flux de règlements futurs probabilisés|
|BE|Best Estimate|MR|Marge de Risque|
|BE\_eng|Meilleure Estimation des engagements|NbC|Nombre de contrats|
|BEC\_eng|Meilleure estimation des engagements cédés|PA|Primes Acquises|
|BEFG|Meilleure Estimation des frais de gestion|PC|Part des Cessionnaires|
|BEGP|Meilleure Estimation des garanties probabilisées|PD|Probabilité de Défaut|
|BEP|Meilleure estimation des engagements pour primes|PFPA|Primes Futures Probabilisé et Actualisé|
|BEPC|Meilleure Estimation des Engagements pour Primes cédés|PPB|Provision pour participation aux bénéfices|
|BES|Meilleure estimation des engagements pour sinistres|PPNA|Provision pour primes non Acquises|
|BESC|Meilleure Estimation des Engagements pour Sinistres cédés|PT|Provision Technique|
|CSR|Capital de Solvabilité Requis|RègC|Règlements cumulés|
|CSRB|Capital de solvabilité requis de base|RègF|Règlements futurs|
|CSRO|Capital de solvabilité requis relative au risque Opérationnel|RF|Les résultats financiers.|
|CU|Charge Ultime|RS|Ratio de sinistralité|
|Dec|Les décaissements|RT|Les résultats techniques.|
|Dot|Dotations|ST|Soldes Techniques|
|Enc|Les encaissements|TC|Taux de Cession|
|FDF|Bénéfices Discrétionnaires Futurs|TFG|Taux de Frais de Gestion|
|FFGF|Flux de Frais de Gestion Futurs|TL|Taux de Liquidation|
|FG|Frais de gestions|TPB|Taux de participation aux bénéfices|


# <a name="_toc138675051"></a>***Liste des figures***

[**Figure 1: Les 3 piliers de la SBR**	13**](#_toc138675109)*

[**Figure 2: Structure d’un bilan**	14**](#_toc138675110)

[**Figure 3: Simulation du cours de l’indice MASI sur une année avec le modèle de Black-Scholes**	29**](#_toc138675111)

[**Figure 4: Cours de l’indice Masi observé sur la même période**	29**](#_toc138675112)

[**Figure 5: Fonctionnement des réseaux de neurones récurrents**	30**](#_toc138675113)

[**Figure 6: Le cours Historiques de Clôture pour l’indice MASI**	32**](#_toc138675114)

[**Figure 7: Courbe de cours prédit et de cours observé**	32**](#_toc138675115)

[**Figure 8: Présentation des risques**	54**](#_toc138675116)

[**Figure 9: Courbe de cours prédit et de cours observé**	73**](#_toc138675117)

[**Figure 10: Onglets de l’application**	74**](#_toc138675118)

[**Figure 11:  Fichier app.R**	75**](#_toc138675119)

[**Figure 12: Aperçu de l’onglet paramètre**	77**](#_toc138675120)

[**Figure 13: Sélection de la date de valeur**	78**](#_toc138675121)

[**Figure 14: Aperçu de la courbe des taux zéro-coupon dans l’application**	79**](#_toc138675122)

[**Figure 15: Zoom sur la courbe de taux zéro coupon (En bleue)**	79**](#_toc138675123)

[**Figure 16: Importation du triangle**	81**](#_toc138675124)

[**Figure 17: Aperçu du paramétrage dans l’application**	82**](#_toc138675125)

[**Figure 18: Vérification de l’hypothèse N°1 sur les années de développement**	83**](#_toc138675126)

[**Figure 19: Vérification de l’hypothèse N°1 sur les années de développement**	84**](#_toc138675127)

[**Figure 20: Vérification de l’hypothèse N°1 sur les années de développement**	85**](#_toc138675128)

[**Figure 21: Importation des données (Capital Décès Dégressif)**	90**](#_toc138675129)

[**Figure 22: Part des cessionnaires**	93**](#_toc138675130)

[**Figure 23: les CSR calculés**	94**](#_toc138675131)




# <a name="_toc138675052"></a>***Liste des tables***

[Table 1:  Marché africain de l’assurance en 2021**	11**](#_toc138675132)*

[**Table 2: Taux de référence des bons du Trésor du 30/12/2022**	18**](#_toc138675133)

[**Table 3: Conversion du taux monétaire en taux actuariel**	20**](#_toc138675134)

[**Table 4: Interpolation des taux actuariels pour avoir des taux de maturités pleines**	21**](#_toc138675135)

[**Table 5: Transformation du taux actuariel en taux ZC avec la méthode Bootstrap**	23**](#_toc138675136)

[**Table 6: Triangle de règlements cumulés d’une assurance AT**	80**](#_toc138675137)

[**Table 7: Données de PA et PPNA**	82**](#_toc138675138)

[**Table 8: Les facteur de développements**	85**](#_toc138675139)

[**Table 9: Règlements futurs cumulées**	86**](#_toc138675140)

[**Table 10: Flux de règlements futurs (Cafh Flows)**	86**](#_toc138675141)

[**Table 11: Cadence de liquidation par année de développement**	87**](#_toc138675142)

[**Table 12: Données du Capital décès dégressif (CDD)**	90**](#_toc138675143)

[**Table 13: Tableau d’amortissement *CRP désigne le capital restant à payer en cas de décès**	91**](#_toc138675144)

[**Table 14: CSR Souscription**	93**](#_toc138675145)

[**Table 15: CSR Sous-risques**	93**](#_toc138675146)

[**Table 16: Marges de risques**	94**](#_toc138675147)

[**Table 17: Échelle de notation**	101**](#_toc138675148)

[**Table 18: Correspondance entre échelle de notation et ratio de solvabilité**	101**](#_toc138675149)

[**Table 19: Correspondance entre Échelle de notation et Probabilité de défaut annuelle**	101**](#_toc138675150)





# <a name="_toc138675053"></a>***Introduction***
<a name="introduction"></a>Suite aux crises multiples qui ont secoué le monde de la finance et de l’assurance notamment celle de 2008, les autorités se sont rendu compte de l’insuffisance de la supervision prudentielle. Cette dernière s’est montrée très chétive lors de la crise d’où la nécessité de mettre en place de nouvelles dispositions prudentielles plus robustes.

C’est dans ce contexte, à l’image de Bâle 2 pour la finance, que la Solvabilité 2 voit le jour dans le milieu de l’assurance. Cette réforme réglementaire européenne vient renforcer la précédente en adaptant au mieux les exigences de fonds propres des compagnies d’assurances et de réassurances aux risques qu’elles encourent.

Les insuffisances évoquées n’ont pas épargné le cadre prudentiel marocain. C’est ainsi que l’**Autorité de Contrôle des Assurances et de la Prévoyance Sociale** (ACAPS**[^1]**) à adopter la norme de **Solvabilité Basée sur les Risques** (SBR) afin de tenir compte de la diversité des risques encourus par les compagnies d’assurances et de réassurances marocaines. La SBR s’articule autour de trois piliers :

- Le **pilier I** regroupe les exigences quantitatives, à savoir les règles de valorisation des actifs et des passifs ainsi que les exigences de capital et leur mode de calcul ;
- Le **pilier II** porte sur les exigences qualitatives et définit les règles de gouvernance et de gestion des risques, en l’occurrence l’évaluation interne des risques de la solvabilité ;
- Le **pilier III** concerne, quant à lui, les obligations de reporting à l’Autorité et de diffusion de l’information au public.



1. # <a name="_toc138675054"></a>**CHAPITRE I : Cadre réglementaire Marocain**

## <a name="_toc138675055"></a>***1.1 Cadre réglementaire Marocain***
<a name="cadre-réglementaire-marocain"></a>Le Maroc est l’un des acteurs majeurs de l’assurance en Afrique. Ses compagnies ne cessent de gagner du terrain dans les marchés de la sous-région notamment en Afrique de l’ouest. Selon un rapport de l’[**Atlas Mag](https://www.atlas-mag.net/article/marche-africain-de-l-assurance-en-2019-chiffre-d-affaires-des-principaux-pays)**[^2]**, le Maroc est classé **2ème** en Afrique et **49ème** mondial avec un **chiffre d’affaires de 5 343 millions USD** en 2021.<a name="tbl-classement"></a> 

<a name="_toc137673494"></a><a name="_toc137673643"></a><a name="_toc137718702"></a><a name="_toc137915585"></a><a name="_toc138675132"></a>**Table 1:  Marché africain de l’assurance en 2021**

|Pays|2002|2006|2010|2014|2018|2019|2020|2021|Évolution 2002/2021|
| :- | :- | :- | :- | :- | :- | :- | :- | :- | :- |
|**Afrique du Sud**|19\.575|40\.743|48\.575|50\.502|49\.002|46\.421|41\.110|51\.215|162%|
|**Maroc**|1\.095|1\.675|2\.599|3\.156|4\.323|4\.628|5\.036|5\.330|387%|
|**Kenya**|369|575|998|1\.766|2\.098|2\.229|2\.120|2\.424|557%|
|**Nigeria**|388|712|1\.340|1\.792|1\.168|1\.393|1\.213|1\.581|307%|
|**Namibia**|321|563|887|995|1\.026|1\.305|788|867|170%|
|**Côte d'Ivoire**|177|288|398|457|629|671|778|806|355%|
|<b>Ghana <sup>(1)</sup></b>|-|165|306|385|605|610|669|789|862%|
|**Maurice**|207|318|508|779|627|516|533|523|153%|
|**Angola**|129|680|828|1\.055|450|374|338|494|283%|
|**Autres pays**|1\.278|2\.019|3\.045|12\.385|13\.769|13\.763|14\.332|15\.491|1112%|

Le Royaume doit se succès à la rigueur de son dispositif prudentiel qui se consolide de plus en plus. La SBR (Solvabilité basée sur les risques) est une réforme prudentielle qui vient en ce sens renforcer cette dynamique.  Elle vise à consolider la résilience des compagnies d’assurances face aux différents risques qu’elles encourent. Elle repose sur trois piliers : le pilier quantitatif, le pilier qualitatif et le pilier informatif**[^3]**.

Le pilier quantitatif définit de nouvelles règles pour calculer le niveau de fonds propres minimum que les assureurs doivent détenir, en fonction de l’ensemble de leur activité et des risques associés. Il introduit également un bilan prudentiel, basé sur la valeur de marché des actifs et des passifs, et une classification des fonds propres éligibles**[^4]**.

Le pilier qualitatif concerne la gouvernance et le contrôle interne des assureurs, ainsi que la gestion des risques. Il impose aux assureurs de mettre en place des fonctions clés, comme la fonction actuarielle ou la fonction de conformité, et de réaliser une évaluation interne des risques et de la solvabilité (ORSA**[^5]**). Il applique aussi le principe de « personne prudente » pour la politique d’investissement des assureurs.

|`  `**Le principe de « personne prudente »**|
| :- |
|Le principe de « personne prudente » est un principe qui s’applique à la politique d’investissement des entreprises d’assurance et de réassurance. Il signifie que les assureurs ne doivent investir que dans des actifs dont ils peuvent correctement identifier, mesurer, suivre, gérer, contrôler et déclarer les risques. Ce principe remplace les limitations d’actif qui existaient auparavant dans le cadre réglementaire. Il vise à garantir l’adéquation des actifs aux engagements envers les assurés, en tenant compte des critères de sécurité, qualité, liquidité et rentabilité.|

Le pilier informatif porte sur le reporting et la publication d’information par les assureurs. Il vise à renforcer la transparence et la discipline de marché, en imposant aux assureurs de communiquer au régulateur et au public des informations sur leur situation financière, leur profil de risque et leur système de gouvernance.

La réforme SBR est entrée en vigueur progressivement au Maroc depuis 2019. Le régulateur du secteur, l’ACAPS (Autorité de contrôle des assurances et de la prévoyance sociale), a élaboré plusieurs textes réglementaires pour accompagner sa mise œuvre. Le dernier projet de circulaire en date concerne le second pilier relatif à la gouvernance**[^6]**.

||
| :-: |
<a name="_toc137673551"></a><a name="_toc137718600"></a><a name="_toc137915562"></a><a name="_toc137978893"></a><a name="_toc138675109"></a>**Figure 1: Les 3 piliers de la SBR**

## <a name="_toc138675056"></a>***1.2 Piliers 1: Exigences quantitatives*** 
<a name="chapitre-i-cadre-réglementaire-marocain"></a><a name="piliers-1-exigences-quantitatives"></a>Sur les trois piliers de la norme SBR, notre rapport de stage se concentre essentiellement sur le pilier 1. Ce dernier spécifie toutes les dispositions réglementaires afin de satisfaire les exigences quantitatives de la norme. La détermination du capital de solvabilité requis (*CSR*) et la fixation des Fonds propres (*FP*) nécessite une analyse économique annuel du bilan prudentiel. L’organisme d’assurance ou de réassurance doit disposer d’une richesse nette suffisante pour faire face à ses risques dans *X%***[^7]** des situations possibles. Cela implique que sa richesse nette soit supérieure ou égale à l’exigence de solvabilité. Le bilan prudentiel SBR est un bilan qui reflète la situation économique des assureurs, et non pas uniquement leur situation comptable. Il se base sur une valorisation des actifs à leur prix de marché, c’est-à-dire le prix auquel ils pourraient être vendus ou transférés. Les passifs sont constitués essentiellement de dettes et des provisions techniques, qui représentent le coût estimé des engagements pris par les assureurs envers les assurés. Les provisions techniques se décomposent en deux éléments :

- Le Best Estimate, qui n’est rien d’autre que la valeur actualisée des flux futurs attendus liés aux contrats en cours. L’actualisation se fait en utilisant une courbe de taux sans risque de référence, qui reflète les conditions du marché.
- La marge de risque, qui correspond au coût du capital nécessaire pour couvrir les risques liés aux passifs jusqu’à leur extinction. Le coût du capital est calculé en appliquant un taux fixe aux exigences de fonds propres futures.

Le montant des provisions techniques à une influence importante sur la solvabilité des assureurs et sur leurs fonds propres. Plus les provisions techniques sont élevées, plus les assureurs doivent avoir de fonds propres pour couvrir leurs risques.

|<p></p><p></p>|
| :-: |
<a name="fig-bilan"></a><a name="_toc137673552"></a><a name="_toc137718601"></a><a name="_toc137915563"></a><a name="_toc137978894"></a><a name="_toc138675110"></a>**Figure 2: Structure d’un bilan**

Le **calcul du capital de solvabilité requis (SCR)** se fait selon une formule standard qui prend en compte les différents types de risques auxquels les assureurs sont exposés. Il s’agit d’une méthode qui part du niveau le plus bas (les risques individuels) et qui remonte au niveau le plus haut (le risque global).

Les risques quantifiables sont regroupés en quatre catégories : les risques de marché, les risques de souscription, les risques de défaut et les risques opérationnels. Pour chaque catégorie, il existe deux façons de mesurer l’impact des risques sur les fonds propres des assureurs :

- L’approche par scénario, qui consiste à appliquer des chocs soudains et extrêmes sur les actifs et les passifs des assureurs, et à observer la variation de leur valeur nette. Par exemple, on peut simuler une baisse des actions, une baisse des taux d’intérêt, un choc de mortalité, une hausse de la sinistralité, etc.
- L’approche par facteurs, qui consiste à appliquer une formule mathématique qui détermine la charge en capital en fonction de paramètres prédéfinis. Par exemple, on peut utiliser un pourcentage des primes ou des provisions pour calculer le risque de souscription.

Les risques ne sont pas indépendants les uns des autres. Il faut donc tenir compte de la diversification entre les risques, c’est-à-dire du fait que certains risques peuvent se compenser ou s’atténuer mutuellement. Pour cela, on utilise des matrices de corrélation qui permettent d’agréger le **SCR** de chaque module et de chaque sous-module.

La réassurance est un moyen pour les assureurs de transférer une partie de leurs risques à un autre assureur. Elle réduit donc le **SCR** des assureurs cédants. Mais elle crée aussi un risque de contrepartie, c’est-à-dire le risque que l’assureur réassureur ne puisse pas honorer ses engagements en cas de sinistre. Il faut donc prendre en compte la réassurance dans la variation des fonds propres après choc.

Les assureurs peuvent aussi mettre en œuvre des actions de gestion pour limiter l’impact des chocs sur leurs passifs. Par exemple, ils peuvent modifier la tarification ou la distribution de leurs produits, ou ajuster leurs garanties ou leurs options. Ces actions de gestion sont prises en compte dans le calcul des provisions techniques après choc.

Enfin, les assureurs peuvent bénéficier d’un ajustement pour augmenter leur capacité d’absorption des pertes par les impôts différés. Cela signifie qu’en cas de perte, ils peuvent réduire leur base imposable et donc leur impôt à payer. Cet ajustement diminue le SCR des assureurs.

L’évaluation des provisions techniques est une étape importante du bilan prudentiel, car elle détermine le coût estimé des engagements pris par les assureurs envers les assurés. Il faut donc que cette évaluation soit encadrée par des règles et des principes, qui garantissent sa fiabilité et sa cohérence. Parmi ces règles et principes, on peut citer :

- L’approche réglementaire vs la liberté de modélisation : il s’agit du choix entre utiliser une méthode standardisée définie par le régulateur, ou utiliser une méthode propre à l’assureur, qui doit être validée par le régulateur.
- La qualité des données et la segmentation : il s’agit de s’assurer que les données utilisées pour l’évaluation sont complètes, exactes et pertinentes, et qu’elles permettent de distinguer les différents types de contrats et de risques.
- La cohérence des hypothèses avec l’expérience et la situation propre de l’institution : il s’agit de vérifier que les hypothèses retenues pour l’évaluation sont basées sur les données historiques et les caractéristiques spécifiques de l’assureur, et qu’elles sont sensibles aux variations des paramètres.
- La possibilité de recourir aux “dires d’experts” : il s’agit de la possibilité d’utiliser le jugement professionnel des experts actuariels pour compléter ou ajuster les données ou les hypothèses, en cas de manque d’information ou d’incertitude.
- La modélisation des frais récurrents en adéquation avec les frontières des contrats : il s’agit de prendre en compte les frais liés à la gestion des contrats, en fonction de leur durée et de leur contenu.
- L’intégration des “management actions” dans l’évaluation des risques Vie : il s’agit de prendre en compte les actions que l’assureur peut mettre en œuvre pour limiter l’impact des chocs sur ses passifs, comme par exemple modifier la tarification ou la distribution de ses produits, ou ajuster ses garanties ou ses options.
- La difficulté de contrôler les approches stochastiques : il s’agit de la difficulté à vérifier la pertinence et la robustesse des méthodes qui utilisent des simulations aléatoires pour évaluer les provisions techniques, notamment en ce qui concerne le générateur de scénarios économiques, l’estimation des paramètres, etc.

L’évaluation des risques financiers est aussi une étape importante du bilan prudentiel, car elle évalue la valeur de marché des actifs détenus par les assureurs. Ainsi, cette évaluation repose sur un certain nombre de principes parmi lesquels nous pouvons citer :

- La valorisation de l’immobilier et du non coté : il s’agit de déterminer le prix auquel les actifs immobiliers ou non cotés en bourse pourraient être vendus ou transférés sur le marché.
- La mise en transparence des OPCVM : connaître la composition détaillée des organismes de placement collectif en valeurs mobilières (OPCVM), qui sont des fonds d’investissement regroupant plusieurs actifs financiers.
- L’ajustement des chocs en fonction de la situation du marché financier et de la géographie du capital : il s’agit d’adapter l’intensité des chocs appliqués aux actifs financiers en fonction du contexte économique et du lieu où ils sont investis.
- La problématique des notations externes : il s’agit du problème lié à l’utilisation des notations attribuées par les agences externes pour évaluer le risque de défaut des actifs financiers, qui peuvent être biaisées ou imprécises.
- La définition des “groupes” et actifs “stratégiques” : il s’agit de définir quels sont les groupes ou les actifs financiers qui ont une importance particulière pour l’assureur, et qui doivent donc être traités différemment.

L’évaluation des impôts différés détermine le montant d’impôt que l’assureur peut économiser ou payer en cas de perte ou de bénéfice. L’évaluation passe par un test de recouvrabilité et la capacité d’absorption des pertes par les impôts différés. L’objectif est de vérifier que l’assureur dispose d’un bénéfice futur suffisant pour utiliser ses impôts différés actifs, c’est-à-dire le montant d’impôt qu’il peut économiser grâce à ses pertes passées ou présentes. Par contraposée, cela revient aussi de vérifier que l’assureur peut bénéficier d’un ajustement pour augmenter la capacité d’absorption des pertes par les impôts différés, c’est-à-dire le montant d’impôt qu’il peut économiser grâce à ses pertes futures.

L’évaluation du capital de solvabilité requis (SCR) est la dernière étape du bilan prudentiel, elle détermine le montant minimum de fonds propres que l’assureur doit avoir pour couvrir ses risques. Il existe deux approches possibles pour calculer le SCR :

- La formule standard, qui est une méthode standardisée définie par le régulateur, qui prend en compte les différents types de risques auxquels les assureurs sont exposés, et qui utilise des paramètres prédéfinis.
- Le modèle interne, qui est une méthode propre à l’assureur, qui prend en compte les spécificités de son profil de risque, et qui utilise ses propres paramètres. Le modèle interne doit être validé par le régulateur.



# <a name="_toc138675057"></a>***2. CHAPITRE II : Construction de la courbe des taux***

## <a name="_toc138675058"></a>***2.1 La construction de la courbe des taux zéro-coupon***
<a name="x2550295fbb3cfba728df7be700e79e4d4dd16d7"></a><a name="sec-courbe_zc"></a>Dans cette partie nous nous intéressons à la construction de la courbe des taux zéro-coupon dont nous avons besoin dans le reste de ce travail afin d’actualiser les flux futurs entrant dans le calcul des différentes Best Estimate. Les taux zéro coupons sont extraits des taux moyens pondérés des transactions des bons de trésor publiées par la [**BANK AL MAGHRIB**](https://www.bkam.ma/Marches/Principaux-indicateurs/Marche-obligataire/Marche-des-bons-de-tresor/Marche-secondaire/Taux-de-reference-des-bons-du-tresor?date=23%2F03%2F2023&block=e1d6b9bbf87f86f8ba53e8518e882982#address-c3367fcefc5f524397748201aee5dab8-e1d6b9bbf87f86f8ba53e8518e882982). Ces taux, sont en effet des taux monétaires pour les maturités inférieures ou égales à un an, alors qu’ils représentent un taux actuariel pour les maturités supérieures à un an. De plus, ils ne sont disponibles que pour certaines maturités.

<a name="tbl-taux_ref"></a><a name="_toc137673495"></a><a name="_toc137673644"></a><a name="_toc137718703"></a><a name="_toc137915586"></a><a name="_toc138675133"></a>**Table 2: Taux de référence des bons du Trésor du 30/12/2022**

|**Date d'échéance**|**Transaction**|**Taux moyen pondéré**|**Taux moyen pondéré (%)**|**Date de la valeur**|**Maturité**|
| :- | :- | -: | :- | :- | -: |
|13/01/2023|322,40|0\.02948|2,948 %|30/12/2022|0\.039|
|23/01/2023|120,47|0\.02930|2,930 %|30/12/2022|0\.067|
|06/03/2023|30,15|0\.02942|2,942 %|30/12/2022|0\.183|
|22/05/2023|168,01|0\.03172|3,172 %|30/12/2022|0\.397|
|19/06/2023|829,46|0\.03008|3,008 %|30/12/2022|0\.475|
|17/07/2023|210,28|0\.03002|3,002 %|30/12/2022|0\.553|
|05/08/2023|116,18|0\.03016|3,016 %|30/12/2022|0\.606|
|11/09/2023|349,31|0\.03045|3,045 %|30/12/2022|0\.708|
|16/10/2023|57,86|0\.03130|3,130 %|30/12/2022|0\.806|
|15/01/2024|62,41|0\.02967|2,967 %|30/12/2022|1\.058|
|18/03/2024|100,37|0\.02987|2,987 %|30/12/2022|1\.233|
|15/04/2024|261,82|0\.02961|2,961 %|30/12/2022|1\.311|
|17/06/2024|53,19|0\.02991|2,991 %|30/12/2022|1\.486|
|15/07/2024|149,79|0\.02989|2,989 %|30/12/2022|1\.564|
|16/09/2024|69,58|0\.03050|3,050 %|30/12/2022|1\.739|
|20/10/2025|100,50|0\.02980|2,980 %|30/12/2022|2\.847|
|20/04/2026|138,51|0\.02941|2,941 %|30/12/2022|3\.353|
|16/04/2029|118,63|0\.03003|3,003 %|30/12/2022|6\.386|
|18/06/2029|115,57|0\.03011|3,011 %|30/12/2022|6\.561|
|16/06/2031|274,67|0\.03126|3,126 %|30/12/2022|8\.583|
|18/07/2033|317,93|0\.03211|3,211 %|30/12/2022|10\.703|
|17/07/2034|61,82|0\.03346|3,346 %|30/12/2022|11\.714|
|16/07/2035|356,46|0\.03279|3,279 %|30/12/2022|12\.725|
|18/08/2036|36,32|0\.03374|3,374 %|30/12/2022|13\.833|
|16/08/2038|135,19|0\.03433|3,433 %|30/12/2022|15\.856|
|16/04/2040|15,09|0\.03488|3,488 %|30/12/2022|17\.547|
|19/02/2046|21,09|0\.03614|3,614 %|30/12/2022|23\.478|
|14/02/2050|13,91|0\.03789|3,789 %|30/12/2022|27\.522|
|20/02/2051|135,76|0\.03612|3,612 %|30/12/2022|28\.553|

La construction de la courbe des taux zéro-coupon passe par les étapes suivantes :

- 1-ère étape : Transformation des taux monétaires en taux actuariels.
- 2-ème étape : Interpolation linéaire afin d’obtenir des taux actuariels pour des maturités pleines.
- 3-ème étape : Calcule des taux zéro coupons à partir des taux actuariels des maturités pleines par la Méthode du Bootstrap.
- 4-ème étape : Extrapolation de la courbe des taux zéro-coupon pour des maturités non observées lointaines par la méthode de Smith-Wilson.

### <a name="_toc138675059"></a><a name="xcbe522a13d0cf3ed962fdea859902dd7c035635"></a>**Transformation des taux monétaires en taux actuariels**
Cette étape consiste à transformer les taux monétaires à des taux actuariels en utilisant la relation suivante :

<a name="eq-tm_to_ta"></a>*Ta=1+n365\*Tm365n-1,  1*

avec :

- *Ta* : Le taux actuariel.
- *Tm* : Le taux monétaire.
- *n* : Le nombre de jours entre la date de valeur et la date d’échéance.
- *365n* : La maturité.

Après l’application de cette formule sur Les données de marché marocain (publiées par la BAM), nous avons obtenu les résultats cités dans le tableau suivant :

<a name="tbl-taux_act"></a><a name="_toc137673496"></a><a name="_toc137673645"></a><a name="_toc137718704"></a><a name="_toc137915587"></a><a name="_toc138675134"></a>**Table 3: Conversion du taux monétaire en taux actuariel**

|<a name="x96b896b92b42645ba88a707007c4252bf9e5cd7"></a>**Maturité**|**Taux actuariel (%)**||**Maturité**|**Taux actuariel (%)**|
| :- | :- | :- | :- | :- |
|0\.039|3,03%||2\.847|2,98%|
|0\.067|3,01%||3\.353|2,94%|
|0\.183|3,02%||6\.386|3,00%|
|0\.397|3,25%||6\.561|3,01%|
|0\.475|3,08%||8\.583|3,13%|
|0\.553|3,07%||10\.703|3,21%|
|0\.606|3,08%||11\.714|3,35%|
|0\.708|3,10%||12\.725|3,28%|
|0\.806|3,18%||13\.833|3,37%|
|1\.058|2,97%||15\.856|3,43%|
|1\.233|2,99%||17\.547|3,49%|
|1\.311|2,96%||23\.478|3,61%|
|1\.486|2,99%||27\.522|3,79%|
|1\.564|2,99%||28\.553|3,61%|
|1\.739|3,05%||||



### <a name="_toc138675060"></a>**Interpolation linéaire de la courbe des taux actuariels**
En réalité, nous ne disposons que des taux actuariels de maturités ayant des valeurs décimales, le but de cette étape est donc la détermination des taux actuariels avec des maturités pleines en utilisant une interpolation linéaire.

Cette opération consiste à déterminer le *DPL* qui correspond au dernier point liquide. Il est déterminé de sorte que le volume cumulé des obligations dont les échéances sont supérieures au DPL et inférieur à *6%* du volume total des transactions prises en compte pour la construction de la courbe des taux zéro-coupon. Il correspond aussi à dernière maturité observable.

La formule d’interpolation pour toute maturité *j* allant de *1,2,…,DPL* est la suivante :

<a name="eq-dpl"></a>*tj=ti+ti+1-tini+1-ni×j-ni ,  2*

avec :

- *tj* : Taux actuariels de maturité pleine j compris entre les maturités *ni* et *ni+1*,
- *ti* : Taux actuariels de maturités *ni*.

<a name="tbl-taux_inter"></a><a name="_toc137673497"></a><a name="_toc137673646"></a><a name="_toc137718705"></a><a name="_toc137915588"></a><a name="_toc138675135"></a>**Table 4: Interpolation des taux actuariels pour avoir des taux de maturités pleines**

|<a name="la-méthode-de-bootstrap"></a>**Maturité**|**Taux actuariel (%)**||**Maturité**|**Taux actuariel (%)**|
| -: | :- | :- | -: | :- |
|1|3,02%||15|3,41%|
|2|3,03%||16|3,44%|
|3|2,97%||17|3,47%|
|4|2,95%||18|3,50%|
|5|2,98%||19|3,52%|
|6|3,00%||20|3,54%|
|7|3,04%||21|3,56%|
|8|3,09%||22|3,58%|
|9|3,14%||23|3,60%|
|10|3,18%||24|3,64%|
|11|3,25%||25|3,68%|
|12|3,33%||26|3,72%|
|13|3,30%||27|3,77%|
|14|3,38%||28|3,71%|


### <a name="_toc138675061"></a>**La méthode de Bootstrap**
La méthode Bootstrap est une technique de reconstitution de la courbe zéro-coupon pas à pas, en déterminant les taux zéro-coupon à partir des taux actuariels, en faisant l’hypothèse que le prix théorique d’une obligation correspond à la somme de ses flux futures actualisés aux taux zéro-coupon de l’échéance de chaque flux. Ainsi, on suppose que les prix des obligations des Bons du trésor sont au pair, c’est-à-dire que le prix d’émission des obligations des bons du trésor et leur valeur nominale sont égaux.

- **Pour une maturité inférieure ou égale à un an** :

Le taux zéro-coupon est donc le taux actuariel de même maturité. Car aucun coupon n’est payé avant l’échéance.

- **Pour une maturité supérieure à un an** :

Le taux zéro-coupon est calculé par la formule suivante :

*Rn=n1+tn1-tn×i=1n-111+Rii-1 .  3*

En effet, on a supposé que le prix théorique d’une obligation correspond à la somme de ses flux futures actualisés aux taux zéro-coupon de l’échéance de chaque flux:

*P=tn\*N1+R1+tn\*N1+R22+…+N+tn\*N1+Rnn,  4*

avec :

- *P* : Prix d’émission du bon de trésor,
- *N* : Valeur Nominale du bon de trésor.

Et puisque nous avons supposé que les obligations des Bons du trésor soient émises au pair, c’est-à-dire que le prix d’émission des obligations des bons du trésor et leur valeur nominale sont égaux *P=N*, on en déduit l’expression:

*1=tn1+R1+tn1+R22+…+1+tn1+Rnn*

*⟹1+tn1+Rnn=1-tn\*i=1n-111+Rii*

*⟹1+Rnn=1+tn1-tn\*i=1n-111+Rii .*

On en arrive à la conclusion :

*Rn=n1+tn1-tn\*i=1n-111+Rii-1*

<a name="tbl-taux_zc"></a><a name="_toc137673498"></a><a name="_toc137673647"></a><a name="_toc137718706"></a><a name="_toc137915589"></a><a name="_toc138675136"></a>**Table 5: Transformation du taux actuariel en taux ZC avec la méthode Bootstrap**

|<a name="x336f36db0687334b747abecf8d379445810500d"></a>**Maturité**|**Taux zéro coupon (%)**||**Maturité**|**Taux zéro coupon (%)**|
| -: | :- | :- | -: | :- |
|1|3,02%||15|3,47%|
|2|3,03%||16|3,50%|
|3|2,97%||17|3,54%|
|4|2,95%||18|3,58%|
|5|2,98%||19|3,61%|
|6|3,00%||20|3,63%|
|7|3,04%||21|3,66%|
|8|3,10%||22|3,69%|
|9|3,16%||23|3,72%|
|10|3,21%||24|3,77%|
|11|3,28%||25|3,83%|
|12|3,37%||26|3,90%|
|13|3,34%||27|3,97%|
|14|3,43%||28|3,86%|


### <a name="_toc138675062"></a>**Extrapolation de la courbe des taux zéro-coupon : Méthode de Smith-Wilson**
La méthode Smith-Wilson est une méthode d’extrapolation de la courbe des taux d’intérêt développée par les chercheurs Smith et Wilson en 1995, et est utilisée pour extrapoler les taux à long terme. Son principe est d’ajuster une courbe mathématique à la courbe des taux observée sur le marché, en utilisant une fonction spécifique appelée “fonction de Smith-Wilson”. Cette fonction est une combinaison de deux termes : le premier terme représente une fonction de décroissance exponentielle, qui est utilisée pour modéliser la partie courte de la courbe des taux ; le second terme est une fonction polynomiale qui est utilisée pour modéliser la partie longue de la courbe des taux.

Une fois que la fonction de Smith-Wilson a été ajustée à la courbe des taux, elle peut être utilisée pour extrapoler les taux pour des maturités plus longues que celles disponibles sur le marché. Cette extrapolation est possible car la fonction de Smith-Wilson est conçue pour s’adapter de manière continue à la fois à la partie courte et à la partie longue de la courbe des taux.

dans ce modèle le taux à terme à long terme est un paramètre d’entrée fixe qui ne varie pas dans le temps à mesure qu’évoluent les prix des obligations. Elle permet aux taux à terme à long terme de converger vers le taux « infini »(Ultimate Forward Rate) choisi et elle offre une base solide pour couvrir le risque de taux d’intérêt à long terme.

Les paramètres d’entrée sont les suivants :

- le UFR (Ultimate Forward Rate)
- *α* la vitesse de convergence vers le UFR.

En fait, sur le marché on observe les prix zéro-coupons de différentes maturités *u1,u2,….,uN* alors Smith-Wilson suppose que le facteur d’actualisation *Pτ* est déterminé par:

*Pτ=e-UFR\*τ+j=1Nγj\*Wτ,μj ,  5*

où:

*Wτ,μj=e-UFR\*τ+μj\*α\*minτ,μj-0,5\*e-α\*maxτ,μj\*eα\*minτ,μj-e-α\*maxτ,μj ,*

avec :

- *W* représente un ensemble de fonctions à noyau pour chaque prix d’obligation observable d’entrée.
- *α* : la vitesse de convergence vers le UFR.
- *N*: le nombre d’obligations ZC dont le prix est observé sur le marché.
- *uj*: la j-ème maturité disponible. .
- *γj* : les inconnus à ajuster par rapport à la courbe des taux zéro-coupon disponible avant extrapolation.

Pour déterminer ces inconnus, on fixe d’abord *UFR* et *α*,le vecteur *γ* s’obtient comme solution d’un système d’équations linéaires définies par l’expression du prix de chaque obligation ZC considérée.

Soit :

*mj=Pμj=e-UFR\*μj+j=1Nγj\*Wτ,μj ,*

sous forme matricielle :

*m=P=µ+γ\*W⇒γ=W-1P-µ,*

avec:

*m=m1,m2,…,mNT*

*P=Pu1,Pu2,…,PuNT*

*µ=e-UFR\*u1,e-UFR\*u2,…,e-UFR\*uNT*

*W= W1N⋯W1N⋮⋱⋮WN1⋯WNN*

*Wij=Wui,uj  i,j=1,…,N*  

Après la détermination des inconnus, on passe au calcul des prix zéro-coupon correspondants aux maturités pleines, et finalement déduire les taux zéro-coupon correspondants à ces maturités par la relation suivante :

*Rt=1Pt1t-1  6*



# <a name="_toc138675063"></a>***3. CHAPITRE III : Valorisation de l’actif***

## <a name="_toc138675064"></a>***3.1 Directives de l’ACAPS***
<a name="directives-de-lacaps"></a>Selon les directions de l’autorité de contrôle des Assurances et de la Prévoyance Sociale, les actifs doivent être évaluer comme suit :

|**Actif**|**Valorisation**|
| :- | :- |
|Actions cotées à la bourse|Dernier cours coté|
|Titres OPCVM et OPCI|Dernière valeur liquidative|
|Titres OPCC et FPCT|Dernière valeur connue|
|Titres de créances négociables, obligations et bons|Valeur de marché|
|Immobilisations corporelles|Valeur comptable|
|Autres créances|Valeur comptable|
|Immobilisations en non-valeur|Valeur nulle|
|Immobilisations incorporelles|Valeur nulle|
|Actifs immobiliers hors OPCI|Valeur de transaction (sinon valeur comptable)|
|Autres actifs|Valeur d’expert (sinon valeur comptable)|

Pour les actions cotées à la bourse de Casablanca, ils sont valorisés à leur dernier cours coté avant la date d’inventaire, ou le moyenne des cours côtés des trois derniers mois précédant la date d’inventaire, si le volume ou la quantité journaliers moyens des transactions sur les 3 derniers mois précédant la date d’inventaire sont inférieurs aux seuils fixés par L’ACAPS.

## <a name="_toc138675065"></a>***3.2 Modélisation du prix des actions***
<a name="chapitre-iii-valorisation-de-lactif"></a><a name="modélisation-du-prix-des-actions"></a>Le prix d’une action ou plus communément appelé cours d’une action représente le prix auquel elle est achetée ou vendue sur un marché boursier. Ce prix fluctue en fonction de l’offre et de la demande pour cette action, ainsi que de nombreux autres facteurs tels que les performances financières de l’entreprise, les conditions économiques générales et les évènements mondiaux. Autrement dit, le cours de l’action représente la valeur perçue de l’entreprise par les investisseurs à un moment.

Ainsi, si la valeur présente de l’action est une donnée du marché, sa valeur future quant à elle est aléatoire d’où la nécessité de sa modélisation.



### <a name="_toc138675066"></a><a name="modèle-de-black-scholes"></a>**Modèle de Black-Scholes**
Le modèle de Black-Scholes modèle a été développé en 1973 par Fischer Black, Robert Merton et Myron Scholes, qui ont reçu le prix Nobel d’économie en 1997 pour leurs travaux. Ce modèle est l’un des concepts les plus importants dans la théorie de la finance modèle. Il permet d’évaluer le prix d’une option européenne en fonction de son type et du prix de l’actif sous-jacent. Le modèle repose sur plusieurs hypothèses dont l’une d’entre elle est que le cours de l’actif sous-jacent suit un mouvement géométrique avec une volatilité constante.

En termes mathématiques, le prix d’une action peut donc être représenté comme une fonction scalaire du temps actuel *t*. Nous noterons cette fonction *St*. Notons qu’en termes techniques, *St* est une série temporelle, qui bien qu’apparemment continue (avec continuité *C0*), est en réalité discontinue (sujette de sauts). De plus, ce n’est pas une fonction dont la dérivée première n’existe pas.

Nous allons modéliser *St* comme une variable stochastique. Dans cette situation, nous sommes tenus de ne pas utiliser les outils standards de calcul (tels que les séries de Taylor, les dérivées, l’intégrale de Riemann), mais sont plutôt contraints d’utiliser les outils de calculs stochastiques (tels que le lemme d’Itô, la dérivée de Radon-Nikodym, Riemann -Stieltjes intégrale) pour faire avancer notre modélisation.

Dans ce contexte, le comportement de la variable *St* peut être décrit pour une Équation Différentielle Stochastique (*EDS*). Dans le cas des actions, l’*EDS* standard utilisée pour modéliser la trajectoire du cours est appelé Mouvement Brownien Géométrique (*GBM* : Geometric Brownian Motion). Sous la mesure de probabilité dite réelle *P*, le mouvement brownien géométrique (*GBM*) est formellement représenté en temps continu de la manière suivante : (voir l’ouvrage C++ For Quantitative Finance**[^8]**)

<a name="eq-gbmp1"></a>*dSt=μStdt+σStdWtP ,  7*

où *μ* représente le drift, *σ* la volatilité et *WP* est mouvement brownien standard sous la probabilité *P*.

Cependant, dans la littérature, cette représentation n’est pas utilisée pour la valorisation des produit dérivés. Il est remplacé par la représentation suivante sous la mesure de probabilité neutre au risque *Q*:

<a name="eq-gbmq"></a>*dSt=rStdt+σStdWtQ  8*

Dans l’[**Equation 8**](#eq-gbmq) précédente, nous avons remplacé *μ* par le taux d’intérêt sans risque *r*, *σ* est la volatilité et *dW* est l’incrément d’un processus de Wiener. L’équation 2 peut en outre être représentée comme suit :

*dStSt=rdt+σdWtQ*

Dans cette dernière équation, nous pouvons identifier le terme *dStSt* du côté gauche de l’équation comme le rendement des capitaux propres. Ainsi, les deux termes du côté droit de l’équation sont un « terme de dérive » et un « terme de volatilité ». Chacun de ces termes est « mis à l’échelle » par les paramètres μ et σ, qui sont calibrés sur les prix actuels du marché des instruments négociés, tels que les options d’achat et de vente.

Intéressons-nous aux solutions *Stt≥0* de l’EDS [**Equation 8**](#eq-gbmq) qui peut être réécrite comme suit :

<a name="eq-inteds"></a>*St=x0+0tSsμdt+σdWsP ;  avec S0=x0  9*

Puisque *μ* et *σ* sont positifs, cela signifie que l’on cherche un processus adapté *Stt≥0* tel que les intégrales *0tSs* et *0tSsdWsP* aient un sens, et qui vérifie l’[**Equation 9**](#eq-inteds), pour chaque *t*.

Commençons par un calcul formel en posant *Yt=logSt* où *St* est une solution de l’[**Equation 9**](#eq-inteds). *St* est un processus d’Itô avec *Ks=μSs* et *Hs=σSs*. Appliquons la formule d’Itô à *fx=logx*. On obtient, en supposant *St* positif :

*logSt=logS0+0tdSsSs+120t-1Ss2σ2Ss2ds ,*

soit, en utilisant [**Equation 7**](#eq-gbmp1) :

*Yt=Y0+0tμ-σ22ds+0tσdWs ,*

puis :

*Yt=logSt=logS0+μ-σ22t+σWt ,*

ainsi :

<a name="eq-solbs"></a>*St=S0expμ-σ22t+σWt ,  10*

est solution de l’EDS.

|||
| :- | :- |

|<p><a name="_toc137978895"></a><a name="_toc138675111"></a><a name="fig-masi_bs"></a>***Figure 3: Simulation du cours de l’indice MASI sur une année avec le modèle de Black-Scholes***</p><p></p>|
| :-: |

|||
| :- | :- |

|<p><a name="_toc137978896"></a><a name="_toc138675112"></a><a name="fig-masi_r"></a>***Figure 4: Cours de l’indice Masi observé sur la même période***</p><p></p><p></p><p></p>|
| :-: |

|||
| :- | :- |


### <a name="_toc138675067"></a><a name="réseaux-de-neurones-récurrents"></a>**Réseaux de neurones récurrents**
Dans cette partie on va s’intéresser à l’entraînement d’un modèle de réseaux de neurones récurrents (**RNN** pour recurrent neural network en anglais), plus spécifiquement au modèle LSTM (Long short-term memory) avec des données historiques de l’indice MASI (Moroccan All Shares Index) afin prédire les cours journaliers de clôture.

Le (RNN) est un type de réseau neuronal artificiel qui utilise des données séquentielles ou des données de séries chronologiques. Ces algorithmes d’apprentissage en profondeur ( Deep Learning ) sont couramment utilisés pour les problèmes ordinaux ou temporels, tels que la traduction linguistique, traitement automatique des langues ( NLP ), la reconnaissance vocale et le sous-titrage d’images, la prédiction des séries chronologiques,*…*

Les réseaux de neurones récurrents utilisent des données de formation pour apprendre. Ils se distinguent par leur mémoire car ils prennent des informations d’entrées précédentes pour influencer l’entrée et la sortie actuelles. Alors que les réseaux de neurones profonds traditionnels supposent que les entrées et les sorties sont indépendantes les unes des autres, la sortie des réseaux de neurones récurrents dépend des éléments antérieurs de la séquence. Alors que les évènements futurs seraient également utiles pour déterminer la sortie d’une séquence donnée.

Une autre caractéristique distinctive des réseaux récurrents est qu’ils partagent des paramètres à travers chaque couche du réseau, alors que les réseaux feedforward (des réseaux de neurones artificiels qui traitent les informations dans une seule direction) ont des poids différents sur chaque nœud. Les **RNN** partagent le même paramètre de poids dans chaque couche du réseau. Cela dit, ces poids sont toujours ajustés au cours des processus de rétropropagation et de descente de gradient pour faciliter l’apprentissage par renforcement.

<a name="_toc137673555"></a><a name="_toc137718604"></a><a name="_toc137915566"></a><a name="_toc137978897"></a><a name="_toc138675113"></a>**Figure 5: Fonctionnement des réseaux de neurones récurrents**

|<p></p><p></p>|
| :-: |
Un inconvénient des RNN standard est le problème du gradient de fuite, dans lequel les performances du réseau de neurones souffrent car il ne peut pas être formé correctement. Cela se produit avec des réseaux de neurones en couches profondes, qui sont utilisés pour traiter des données complexes.

Les RNN standard qui utilisent une méthode d’apprentissage basée sur le gradient se dégradent à mesure qu’ils grandissent et deviennent plus complexes. Le réglage efficace des paramètres aux premières couches devient trop long et coûteux en calculs.

Une solution au problème s’appelle les réseaux de mémoire longue à court terme (LSTM), que les informaticiens Sepp Hochreiter et Jurgen Schmidhuber ont inventés en 1997. Les RNN construits avec des unités LSTM classent les données en cellules de mémoire à court terme et à long terme. Cela permet aux RNN de déterminer quelles données sont importantes et doivent être mémorisées et renvoyées dans le réseau, et quelles données peuvent être oubliées.

Dans notre cas, Nous nous sommes focalisés sur l’application du modèle LSTM sur les données de l’indice MASI. Notre échantillon comporte *5000* observations journalières du cours d’ouverture, cours de clôture, le cours le plus bas, le cours plus haut et la variation du cours entre deux dates successives.

|**Date**|**Dernier**|**Ouverture**|**Plus Haut**|**Plus Bas**|**variation**|
| :- | -: | -: | -: | -: | -: |
|2022-01-24|13753\.50|13783\.81|13815\.59|13753\.05|-0.0022|
|2022-01-21|13783\.81|13777\.59|13812\.43|13769\.84|0\.0005|
|2022-01-20|13777\.59|13737\.71|13814\.82|13734\.73|0\.0029|
|2022-01-19|13737\.71|13768\.05|13817\.94|13734\.76|-0.0022|
|2022-01-18|13768\.05|13770\.78|13815\.37|13767\.98|-0.0002|
|2022-01-17|13770\.78|13784\.31|13784\.31|13748\.24|-0.0010|
|2022-01-14|13784\.31|13588\.24|13784\.72|13551\.04|0\.0144|
|2022-01-13|13588\.24|13531\.26|13588\.24|13506\.23|0\.0042|
|2022-01-12|13531\.26|13486\.31|13532\.13|13481\.22|0\.0033|
|2022-01-10|13486\.31|13477\.25|13503\.15|13441\.78|0\.0007|
|2022-01-07|13477\.25|13368\.77|13477\.25|13335\.97|0\.0081|
|2022-01-06|13368\.77|13290\.62|13369\.02|13290\.62|0\.0059|
|2022-01-05|13290\.62|13278\.48|13306\.00|13269\.36|0\.0009|
|2022-01-04|13278\.48|13296\.29|13328\.50|13278\.48|-0.0013|
|2022-01-03|13296\.29|13358\.32|13363\.06|13277\.80|-0.0046|

*La figure suivante donne un aperçu de Dernier cours de cet indice entre les années 2002 et 2022.*

<a name="_toc137673556"></a><a name="_toc137718605"></a><a name="_toc137915567"></a><a name="_toc137978898"></a><a name="_toc138675114"></a>**Figure 6: Le cours Historiques de Clôture pour l’indice MASI**

||
| :-: |
<a name="fig-masi_plot"></a>Les réseaux de neurones récurrents sont réputés être plus performants comparés aux autres méthodes en termes de prédiction de série chronologique. Ainsi, il est tout naturel de s’attendre à un excellent score lors d’une application du modèle LSTM. Nous allons voir plus de détails sur la méthode de ce modèle sur le langage python la [**Section 7.1**](#sec-rnn_app).

Le graphique suivant est une représentation conjointe du dernier cours observé (en bleu) et le cours prédit (en orange) par notre modèle sur la même période.

<a name="_toc137673557"></a><a name="_toc137718606"></a><a name="_toc137915568"></a><a name="_toc137978899"></a><a name="_toc138675115"></a>**Figure 7: Courbe de cours prédit et de cours observé**

||
| :-: |
<a name="fig-prediction_masi"></a>Une remarque flagrante est que les deux courbes sont presque confondues. Ce constat s’explique par la faiblesse de la valeur du RMSE qui vaut *29,44***.**

La racine de l’erreur quadratique moyenne (en anglais, root-mean-square error ou RMSE) est une mesure de l’écart type des résidus. Plus précisément, elle mesure la différence entre les valeurs prédites par le modèle et les valeurs observées. En termes de cohérence et de précision, le modèle LSTM nous a donné de meilleurs résultat comparé à celui de Black & Scholes.



# <a name="_toc138675068"></a>***4. CHAPITRE IV : Valorisation des provisions techniques prudentielles***
## <a name="_toc138675069"></a>***4.1 Généralité***
<a name="généralité"></a>Les provisions techniques prudentielles bruts de réassurance sont valorisées en considérant les contrats dont l’engagement de l’entreprise est en cours à la date d’inventaire. Les contrats d’assurance non-vie à tacite reconduction dont la date d’effet intervient postérieurement à la date d’inventaire et dont le préavis de résiliation a expiré à cette date sans qu’il y ait une demande de résiliation sont également pris en considération.

Elles sont évaluées comme suit :

*PT=BEeng+BEFG+MR,  11*

avec :

- *PT* : la provision technique.
- *BEeng* : La meilleure estimation des engagements correspond à la somme probabilisée et actualisée de flux de trésorerie futurs afférents aux engagements de l’entreprise d’assurances et de réassurance au titre des contrats souscrits et déterminée, selon la nature des opérations d’assurance.
- *BEFG* : La meilleure estimation des frais de gestion correspond à la somme probabilisée et actualisée des flux de frais de gestion des contrats et déterminée, selon la nature des opérations d’assurance.
- *MR* : La marge de risque correspond au coût d’immobilisation du capital de solvabilité requis afférent aux engagements garantis. Elle est calculée, séparément pour les engagements des opérations d’assurances vie et rentes découlant des opérations non vie ainsi que pour les engagements des opérations non vie.



## <a name="_toc138675070"></a>***4.2 Opérations d’assurance vie, décès ou capitalisation***
<a name="x32462c7e3a0a11848884f7548d4747bc280232c"></a>L’assurance vie est un instrument financier largement utilisé qui offre une protection et des avantages financiers à long terme. Il s’agit d’un contrat entre un assuré et un assureur, dans lequel l’assuré paie régulièrement des primes en échange d’une garantie de versement d’un capital ou d’une rente à un bénéficiaire désigné en cas de décès de l’assuré. Cependant, l’assurance vie ne se limite pas uniquement à la protection en cas de décès, elle peut également offrir des avantages supplémentaires tels que l’accumulation d’épargne, la constitution d’un capital pour la retraite ou des possibilités de planification successorale.

L’assurance vie fonctionne sur le principe de la mutualisation des risques. Les primes payées par les assurés sont regroupées pour former un fonds commun, à partir duquel les prestations sont versées aux bénéficiaires advenant le décès de l’assuré. Ce mécanisme permet de protéger financièrement les proches et de garantir une sécurité financière dans des moments difficiles.

L’une des caractéristiques clés de l’assurance vie est sa nature flexible. Les polices d’assurance vie peuvent être adaptées aux besoins spécifiques de chaque individu, en termes de durée, de montant de la prime et de type de couverture. Il existe différents types d’assurance vie, tels que l’assurance vie temporaire (ou temporaire renouvelable), l’assurance vie entière, l’assurance vie universelle et l’assurance vie variable, offrant ainsi une gamme d’options pour répondre aux objectifs financiers et aux préférences de chacun.
### <a name="_toc138675071"></a><a name="xeb1f9d92a4c5859eacf38eb19f2fdc8a983fcd5"></a>**Meilleure estimations des engagements (BEeng)**
Pour les opérations d’assurance vie, décès ou de capitalisation hors unités de compte, la meilleure estimation des engagements comprend la meilleure estimation des garanties probabilisées et les bénéfices discrétionnaires futurs.

*BEeng=BEGP+BDF ,  12*

avec :

- *BEGP*: la meilleure estimation des garanties probabilisées.
- *BDF*: les bénéfices discrétionnaires futurs.
#### <a name="sec-megp"></a>**Meilleure estimation des garanties probabilisées**
La meilleure estimation des garanties probabilisées est calculée garantie par garantie et tête par tête, en actualisant les flux de trésorerie futurs probabilisés, afférents aux engagements garantis à la date d’inventaire. Toutefois, l’entreprise d’assurances et de réassurance peut procéder à une agrégation en retenant des critères homogènes, notamment l’âge et ce, après accord de l’Autorité.

*BEGP=t=0t=NDect-Enct1+rtt ,*

avec :

- *Enct*: Les encaissements à la date *t* qui correspondent aux engagements des assurés.
- *Dect*: Les décaissements à la date *t*. qui correspondent aux règlements de toutes prestations garanties au titre des contrats, y compris les rachats. Ils sont déterminés en tenant compte des engagements contractuels et en utilisant, le cas échéant, les bases techniques suivantes :
- **La table de mortalité**: La table de mortalité TV 88-90 pour les assurances en cas de vie ou la table de mortalité TD 88-90 pour les assurances en cas de décès (**prévues à l’ANNEXE N°3**), auxquelles l’entreprise d’assurances et de réassurance peut substituer une table de mortalité d’expérience, matérialisant la mortalité propre à la population de ses assurés et ce, après accord de l’Autorité ;
- **La table de rachat en montant**.
- **La table de résiliation**.
- **Un taux de sortie en rente**.

|`  `Remarque|
| :- |
|<p>Les flux de trésorerie futurs probabilisés précités sont déterminés en considérant un horizon de projection suffisant pour la couverture de l’ensemble de la durée de vie des engagements à la date d’inventaire.</p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p>|
|`  `Exemple:|
|<p>Un contrat d’assurance mixte à prime unique sur *N* années est un type de contrat d’assurance-vie qui permet de financer l’assurance-vie en une seule fois. Cela signifie que vous payez une prime unique pour couvrir toute la durée du contrat. Ce type de contrat est destiné aux personnes qui disposent d’un capital et souhaitent diversifier leurs placements tout en protégeant leurs proches. Dans sa variante « mixte », elle permet de réaliser un placement rémunérateur tout en assurant une couverture financière à ses proches.</p><p>Si on prend l’exemple d’un contrat d’assurance-vie mixte de capital en cas de vie égale au capital en cas de décès *K*. Soit *qx+t* la probabilité qu’un individu d’âge *x* lors de la souscription décéde entre *x+t* et *x+t+1*. On note *NbPt* le nombre de police en début de période *t* et *rs* le taux ZC. La prestation correspondante à ce contrat en date t :</p><p>*Dect=K×NbPt×qx+t×1+rtt ,  13*</p>|


#### <a name="bénéfices-discrétionnaires-futurs"></a>**Bénéfices discrétionnaires futurs**
Les bénéfices discrétionnaires futurs en assurance sont une partie des engagements de l’assureur qui incluent les participations aux bénéfices futurs (appelés Future Discretionary Benefits ou FDB) qui sont purement discrétionnaires et ne sont pas garantis par le contrat ou la réglementation. Ils dépendent de la performance financière de l’assureur et de sa politique de distribution. Leur meilleure estimation est donnée par la formule suivante :

*BDF=PPB+TPB×ST+SF×1ST+SF>0,  14*

avec :

- *PPB* : Le montant de la provision pour participation aux bénéfices, évaluée à la valeur comptable.
- *(ST+ST)*: Somme des soldes techniques et financiers.
- *TPB* : Le taux de participation au bénéfice moyen servi aux assurés.

**Le taux de participation aux bénéfices moyen servi aux assurés** est calculé en considérant le rapport entre la somme des dotations au titre, des trois derniers exercices clos au moins, affectées à la provision pour participation aux bénéfices afférente aux opérations d’assurance vie, décès ou de capitalisation hors unités de compte et la somme des résultats techniques et financiers des dites opérations sur la même période. En notation mathématique :

*TPB=DotRT+RF,  15*

avec :

- *Dot* : somme des dotations au titre, des trois derniers exercices clos au moins.
- *RT* :les résultats techniques.
- *RF* :les résultats financiers.
### <a name="_toc138675072"></a><a name="xb36307078f8a6b20714aed4cb695975c0bea969"></a>**Meilleure estimation des frais de gestions (BEFG)**
La meilleure estimation des frais de gestion correspond à la somme actualisée des flux de frais de gestion futurs probabilisés.

*BEFG=t=1NFGt1+rtt  16*

Les frais de gestion futurs sont estimés sur la base d’une projection effectuée en considérant un horizon de projection suffisant pour la couverture de la durée de vie des engagements à la date d’inventaire. Ils sont déterminés pour chaque année de projection en multipliant le nombre de contrats par le montant de frais de gestion unitaire moyen.

*FGt=NbCt×FGUt ,  17*

avec :

- *FGUt* : Le montant de frais de gestion unitaire moyen est estimé en considérant la moyenne sur les trois derniers exercices clos des montants de frais de gestion unitaires.
- *NbCt* : Le nombre de contrats précité est estimé par sous-catégories, compte tenu des bases techniques suivantes (La table de mortalité, La table de rachat en nombre, La table de résiliation).
- *FGt* : Les frais de gestions.



Le montant de frais de gestion unitaire au titre de chaque exercice clos, correspond au rapport entre le montant de frais de gestion déterminé par sous-catégories et le nombre de contrats ou d’adhérents pour les contrats d’assurance de groupe, à l’ouverture de l’exercice clos considéré.

*FGUt=13×FGt-1NbCt-1+FGt-2NbCt-2+FGt-3NbCt-3  18*

## <a name="_toc138675073"></a>***4.3 Rentes découlant des opérations non-vie***
<a name="rentes-découlants-des-opérations-non-vie"></a>La meilleure estimation des engagements pour les rentes découlant des opérations d’assurance non vie correspond à la meilleure estimation des garanties probabilisées déterminée avant.

*BEeng=BEGP ,  19*

avec :

- *BEeng* : la meilleure estimation rentes découlant des opérations d’assurance non vie.
- *BEGP* : la meilleure estimation des garanties probabilisées.

La meilleure estimation des frais de gestion, pour les rentes découlant des opérations d’assurance non vie est déterminée de la même façon comme avant.

## <a name="_toc138675074"></a>***4.4 Opérations d’assurance non vie hors rentes***
<a name="x35be4e1d432b72e5eca82ccc14d28e032b67b9f"></a><a name="x95164bc6af2e862e4c417e49c6d46de2a1b5d80"></a>L’assurance non-vie, également connue sous le nom d’assurance dommages, est un secteur d’assurance qui vise à protéger les biens et les responsabilités des individus et des entreprises contre divers risques. Et il couvre une vaste gamme de domaines, tels que les accidents, les catastrophes naturelles, les dommages matériels, la responsabilité civile, les pertes financières, les vols et bien d’autres encore.

Elle repose aussi sur le principe de la mutualisation des risques, telle que Les assurés paient des primes périodiques à une compagnie d’assurance en échange d’une garantie de recevoir une indemnisation en cas de sinistre. L’assureur collecte les primes de nombreux assurés et utilise ces fonds pour couvrir les pertes de ceux qui ont subi des dommages assurés. Ainsi, l’assurance non-vie permet de répartir les risques et de fournir une protection financière contre les évènements imprévus qui pourraient causer des pertes matérielles ou des responsabilités juridiques.

L’assurance non-vie offre une grande variété de produits et de polices adaptés à différents besoins. Parmi les exemples courants d’assurances non-vie, on trouve l’assurance automobile, l’assurance habitation, l’assurance responsabilité civile, l’assurance santé, l’assurance voyage, l’accident de travail, l’assurance entreprise, etc. Chacune de ces polices est conçue pour offrir une protection spécifique contre les risques liés à ces domaines.

### <a name="_toc138675075"></a><a name="la-meilleure-estimation-des-engagements"></a>**La meilleure estimation des engagements**
la meilleure estimation des engagements comprend la meilleure estimation des engagements pour sinistres nets de recours et la meilleure estimation des engagements pour primes.

*BEeng=BES+BEP  20*

#### <a name="x9db0096445a49d940cc69c0286ca1bcb6499e49"></a>**La meilleure estimation des engagements pour primes (BEP)**
La meilleure estimation des engagements pour primes correspond à la différence entre :

- La somme actualisée des flux de règlements futurs probabilisés nets de recours relatifs aux sinistres non encore survenus afférents aux contrats.
- Le montant des primes futures probabilisé et actualisé à la date d’inventaire, net des frais d’acquisition, afférentes aux contrats.

*BEP=t≥1​FRFPt1+rtt-PFPA ,  21*

avec:

- *PFPA* : Le montant des primes futures probabilisé et actualisé à la date d’inventaire, net des frais d’acquisition, afférentes aux contrats à tacite reconduction
- *FRFPt*: La somme actualisée des flux de règlements futurs probabilisés nets de recours relatifs aux sinistres non encore survenus, telle que pour une année de projection donnée:

*FRFPt=TL\*RS\*PPNA+PFP,  22*


où:

- *TL*: le taux de liquidation, il est estimé en fonction de la cadence de liquidation des engagements pour sinistres survenus.
- *RS*: le ratio de sinistralité moyen telle que:

*RSt=CUt+CUt-1+CUt-2PAt+PAt-1+PAt-2,  23*

avec :

- *CU*: La charge ultime visée correspond, par exercice de survenance, à la somme des règlements cumulés et des règlements futurs au titre de l’année de survenance considérée.
- *PA* les primes acquises.

Tell que :

*CUt=RègCt+RègFt ,  24*

avec :

- *RègCt* : les règlements cumulés.
- *RègFt*: les règlements futurs.
- *PPNA*: La provision pour primes non acquises.
- *PFP*: Le montant des primes futures probabilisé.

#### <a name="xb466634c561e035f1de049d287c041259c7ccc5"></a>**La meilleure estimation des engagements pour sinistres nets (BES):**
La meilleure estimation des engagements pour sinistres nets de recours est déterminée en actualisant, les flux de règlements futurs probabilisés nets de recours relatifs aux sinistres survenus afférents aux contrats.




*BES=t≥1​FRFPt1+rtt ,  25*

avec:

- *FRFPt* : les flux de règlements futurs probabilisés nets de recours relatifs aux sinistres survenus, sont estimés sur la base d’un triangle de règlements par année de survenance net de recours conformément à la méthode exigée par l’ACAPS.
#### <a name="x574a46407ada84d5774a3057497baf873ebb70b"></a>**Méthode de calcul des flux de règlements futurs probabilisés pour les opérations non-vie hors rentes**
#### <a name="sec-ladder"></a>**Méthode des cadences – Chain Ladder**
La méthode de Chain Ladder est celle spécifiée dans l’annexe 5 de la circulaire de l’*ACAPS* sur la *SBR*. Les méthodes de cadences de règlement se basent sur le principe que la vitesse des règlements, en pourcentage de la charge finale de sinistres, est constante d’une année de survenance à l’autre. Ainsi les paiements réalisés permettent d’estimer les provisions pour sinistres à payer. Cette méthode est l’une des plus utilisée sur le marché. Elle tient cette célébrité de sa simplicité de calcul ainsi que de son ancienneté. Cette méthode est généralement utilisée pour les paiements cumulés, notés *Ci,j*, où *i* représente l’exercice de survenance et *j* représente la période de développement.

|Exercice de survenance|1er bilan|2ème bilan|3ème bilan|4ème bilan|
| :-: | :-: | :-: | :-: | :-: |
|1|*C1,1*|*C1,2*|*C1,3*|*C1,4*|
|2|*C2,1*|*C2,2*|*C2,3*||
|3|*C3,1*|*C3,2*|||
|4|*C4,1*||||
Conformément à la spécification technique de l’ACAPS, l’estimation des flux de règlements futurs probabilisés nets de recours relatifs aux sinistres survenus (*FRFP*) passe par les étapes citées ci-après.







|`  `Étape 1 : Constitution du triangle des règlements cumulés net de recours :|
| :- |
|<p>Pour chaque année de survenance, on construit le triangle des règlements nets de recours à partir des données d’inventaire. La longueur d’historique des triangles des règlements doit correspondre à la nature du risque analysé et couvrir toute la durée de vie des engagements à la date d’inventaire. L’entreprise d’assurances et de réassurance doit expliquer pourquoi la méthode utilisée pour sa détermination est adaptée.</p><p></p><p></p><p></p>|
|`  `Étape 2 : Calcul des facteurs de développement individuels :|
|<p>Ils sont déterminés à partir du triangle de règlement cumulé par la formule suivante :</p><p></p><p>*fi,j=Ci,j+1Ci,j,*  pour *i×j∈{1,…,n}×{1,…,n}  26*</p><p></p>|
|`  `Étape 3 : Vérification des hypothèses :|
|<p>Cette méthode repose sur certaines hypothèses qui faudrait vérifier avant de poursuivre les calculs.</p><p>- **Hypothèse Nº1 :** Pour *j* allant de *1* à n, les facteurs de développement *fi,j* sont indépendants de l’année de survenance.</p><p>Les facteurs de développement individuels pour une année de développement j ne doivent pas s’écarter significativement de la moyenne des facteurs de développement individuels pour cette même année.</p><p>- **Hypothèse Nº2 :** L’hypothèse centrale de cette méthode est celle de la stabilité des cadences de paiements. Il existe des facteurs de développements *f0,…,fn-1>0* tels que *∀0≤i≤n* et *∀0≤j≤n*, on a :</p><p>*ECi,j/Ci,0,…,Ci,j-1=ECi,j/Ci,j-1=fj-1Ci,j-1*.</p><p>Pour chaque année de développement *j*, le nuage de points représentant les règlements cumulés de d’une année *j+1* par rapport aux règlements cumulés de l’année j doit être approché significativement par une droite.</p>|
|`  `Étape 4 : Calcul des facteurs de développement communs :|
|<p>Un facteur de développement commun est un coefficient qui permet de prédire les données futures manquantes à partir des données observées. La formule pour calculer les facteurs de développement communs est la suivante :</p><p>*fj=i=0n-j+1Ci,j+1i=0n-j+1Ci,j ,  27*</p><p>où *fj* est le facteur de développement commun de l’année de développement *j* à *j+1*, *Ci,j* est le règlement cumulé de l’année de survenance *i* à l’année de développement *j*, et *n* est le nombre d’années de survenance</p><p></p>|
|`  `Étape 5 :Calcul des règlements cumulés futurs par année de survenance :|
|<p>Les règlements cumulés futurs sont estimés sur la base du triangle cumulé comme suit :</p><p>*Ci,j+1=Ci,n-i×k=n-ijfk ,  28*</p><p>Où :</p><p>- *Ci,j+1* : le règlement cumulé futur de l’année de survenance *i.*</p><p>- *Ci,n-i* : le règlement cumulé de l’année de survenance *i* à l’année de développement *n-i.*</p><p>- *fk* : le facteur de développement commun de l’année de développement *k* à          *k+1.*</p><p>- *n* : le nombre d’années de survenance.</p><p>La Provision pour Sinistre à Payer (*PSAP*) est déduite des *Ci,j* et des *Ci,j* par la formule :</p><p></p><p>*PSAP=i=0n-1Ci,n-Ci,n-i  29*</p>|
|`  `Étape 6 : Constitution du triangle des règlements décumulés futurs par année de survenance :|
|<p>A la sortie de l’étape 5, nous disposerons d’une matrice de règlements cumulés. Cette étape consiste à la décumuler en utilisant la formule suivante :</p><p></p><p>*Ri,j=Ci,j-Ci,j-1   pour  1≤i,j≤n ,  30*</p><p>avec :    *Ci,j=Ci,j* lorsque *i≤j*.</p><p></p><p></p><p></p>|
|`  `Étape 7 : Calcul des flux de règlements futurs nets de recours (somme des diagonales) :|
|<p>Les flux de règlements futurs nets correspondent à la somme des éléments de la diagonales du triangle décumulé inférieur obtenu à l’étape 6 :</p><p>*FRFP=Rp=i=p+1nRi,n-i+p+1  avec  1≤p≤n  31*</p>|

Bien que la méthode de Chain Ladder soit celle préconisée par l’ACAPS dans le cadre de la *SBR*, il existe sur marché d’autres méthodes de calcul des flux de règlements futurs.
#### <a name="méthode-des-cadences-avec-inflation"></a>**Méthode des cadences avec inflation**
Cette variante de la méthode des cadences tient compte de l’inflation de façon explicite. On calcule les paiements annuels en faisant la différence entre les colonnes successives du triangle des paiements cumulés. On ajuste ces paiements annuels en devises (MAD par exemple) constants en utilisant un indice d’inflation, puis on les cumule pour obtenir un triangle de montants cumulés en francs constants. On applique ensuite la méthode des cadences.



#### <a name="la-méthode-du-ratio-de-paiement"></a>**La méthode du ratio de paiement**
Cette méthode attribuée à Sawkins en 1975 est semblable à la méthode des cadences de développement avec inflation, sauf que les coefficients de passage *fj* sont calculés comme une moyenne de ratios et non comme un ratio de moyennes :

*fj=1n-j-1i=0n-j-1Ci,j+1Ci,j  32*
#### <a name="la-méthode-du-ratio-de-paiement-1"></a>**La méthode du ratio de paiement**
La méthode de Bornhuetter-Ferguson**[^9]** est une méthode de provisionnement qui repose sur l’idée que les pertes finales, attendues pour une année de survenance sont connues a priori et que le rythme des paiements est stable d’une année à l’autre. Elle combine les caractéristiques de la méthode des cadences et de la méthode du ratio de sinistralité attendu. Elle utilise des facteurs de développement pour estimer le pourcentage de pertes rapportées ou payées et ajoute les pertes attendues multipliées par le pourcentage de pertes non rapportées ou non payées. Elle est surtout utilisée quand les pertes sont de faible fréquence mais de forte gravité.

En résumé, elle suppose que l’on dispose d’une information externe sur la valeur probable finale du coût total des sinistres, que l’on appelle *A*, et que l’on connaisse la proportion de sinistres attendus ( réf**[^10]** ). Cette méthode se formule comme suit :

*L=D×1LDF+A×1-1LDF ,  33*

avec :

- *L* : coût total estimé par cette méthode.
- *D* : coût total estimé en fonction des sinistres connues.
- *A* : coût total (connus + tardifs) attendu a priori.
- *LDF* : proportion de la liquidation déjà constatée.

||<p>**Exemple**</p><p>Imaginons que le tarif ait été fixé en prévoyant une sinistralité totale de *90*, que la part des sinistres connus au premier bilan soit habituellement de *40%* et que la sinistralité observée au premier bilan soit de *36*.</p><p>Si l’on pense que le tarif était bien établi, il n’y a pas lieu de changer la sinistralité totale et le montant des tardifs à provisionner est de *90-36=54*.</p><p>Si l’on pense que la part des sinistres connus au premier bilan est un indicateur fiable, il y a lieu de considérer que la sinistralité totale sera de *36/40%=90* et de provisionner 54 de tardifs.</p><p>L’application de la méthode Bornhuetter-Ferguson donne un résultat intermédiaire calculé ainsi :</p><p>*L=90×40%+90×60%=90*, soit un volume de tardifs attendu de *54*.</p>|
| :-: | :- |

Plusieurs auteurs ont exprimé l’opinion que cette méthode est plus performante que la méthode des cadences de développement, en début de développement.

### <a name="_toc138675076"></a><a name="x7e63ab4301a770f99d7cb8d654e83cd2564e4b4"></a>**La meilleure estimation des frais de gestion**
la meilleure estimation des frais de gestion correspond à la somme actualisée des flux de frais de gestion futurs liés aux contrats.

*BEFG=t≥1​FFGFt1+rtt ,  34*

avec:

- *FFGF*: les flux de frais de gestion futurs tels que:

*FFGF=TFG×BES+BEP ,  35*

et:

- *TFGM* : Le taux de frais de gestion moyen, il est estimé, par sous-catégories d’opérations d’assurance, en considérant la moyenne sur les trois derniers exercices clos des taux de frais de gestion.

Donc:

*TFG=TFGt+TFGt-1+TFGt-23 ,  36*

ainsi que :

*TFGt=FGBES+REC ,  37*

avec :

- *FG*: le montant frais de gestion.
- *REC* : les règlements au titre de l’exercice clos.


## <a name="_toc138675077"></a>***4.5 Marge de risque***

La marge de risque est calculée séparément pour les engagements vie et rentes découlant des opérations non vie ainsi que pour les engagements des opérations non vie comme suit :

*MR=α×i≥0​CSRi1+ri+1i+1 ,*

où :

- *α* : représente le taux du coût du capital, pas encore publié mais établi à *α=6%* dans notre projet.
- *CSRi* : représente le capital de solvabilité requis projeté à la date *i* compte non tenu des exigences de capitaux relatives aux risques opérationnel, de marché, de concentration et de contrepartie. Il est calculé comme suit :

*CSRi=BEengiBEeng0×CSR0 ,*

- *BEengi* : correspond à la meilleure estimation des engagements projetée à la date *i*.
- *CSR0* : représente le capital de solvabilité requis à la date d’inventaire compte non tenu des exigences de capitaux relatives aux risques opérationnel, de marché, de concentration et de contrepartie.
- *ri* : correspond à la structure par terme de la courbe des taux fixée par l’Autorité.


# <a name="_toc138675078"></a>***5. CHAPITRE V : Part des cessionnaires***
La cession est une opération par laquelle un assureur transfère une partie de son risque accepté à un réassureur. Elle permet à l’assuré, la cédante, de réduire son exposition au risque en transférant une parties de ces engagements à un ou plusieurs cessionnaires en échange de primes versées. La réassurance renforce ainsi la solvabilité de l’assureur.
## <a name="_toc138675079"></a>***5.1 Part des cessionnaires dans les provisions techniques prudentielles***
<a name="xf3f8abd7a5710234231d4d992dd0ccf8ee2969b"></a>La part des cessionnaires dans les provisions techniques prudentielles est évaluée en considérant la différence entre d’une part, la meilleure estimation des engagements cédés et d’autre part, l’ajustement pour défaut de contrepartie.

*PC=BEC-Adj  38*

## <a name="_toc138675080"></a>***5.2 La meilleure estimation des engagements cédés (BEC)***
### <a name="xa95ba47c318081750f82f16389a34a7647ac1fa"></a><a name="_toc138675081"></a><a name="x0f00ae71319169104bfd1725b5f02737fc4d35e"></a>**Les opérations d’assurance vie, décès ou de capitalisation**
la meilleure estimation des engagements cédés est évaluée en multipliant la meilleure estimation des engagements par le rapport entre d’une part, la part des cessionnaires dans les provisions mathématiques et dans les provisions pour capitaux, rentes et rachats à payer et d’autre part, la somme des provisions mathématiques , des provisions pour capitaux, rentes et rachats à payer bruts de réassurance.

*BEC=TC×BEeng ,  39*

avec :

- *TC* (taux de cession): le rapport entre d’une part, la part des cessionnaires dans les provisions mathématiques et dans les provisions pour capitaux, rentes et rachats à payer et d’autre part, la somme des provisions mathématiques, des provisions pour capitaux, rentes et rachats à payer bruts de réassurance.

### <a name="_toc138675082"></a><a name="les-opérations-non-vie"></a>**Les opérations non-vie**
Pour les opérations non vie, la meilleure estimation des engagements cédés correspond à la somme de la meilleure estimation des engagements pour sinistres cédés et de la meilleure estimation des engagements pour primes cédés.

*BEC= BESC+ BEPC ,  40*

avec :

|`  `Étape Nº1: Calcul des meilleures estimations cédées projetées|
| :- |
|<p>**Pour les opérations d’assurance non-vie hors rentes:**</p><p>Posons *Ftt>0* étant les flux de règlements futurs probabilisés. La meilleure estimation des engagements cédés au titre de l’année de projection *BECi* est calculée comme suit :</p><p>*BECi=BESi×RS0+BEPi×RP0 ,  41*</p><p>où:</p><p>- *BESi=t>i​Ft1+rtt*, avec *rt* calculés à partir de la courbe des taux fixée par l’Autorité.</p><p>- *BEPi*: correspond à la meilleure estimation des engagements pour primes projetée à la date i.</p><p>- Les termes *RS0* et *RP0* correspondent aux ratios de passage utilisés pour le calcul de la meilleure estimation des engagements pour sinistres cédés et pour primes cédés respectivement à la date d’inventaire.</p><p>Pour les opérations d’assurance vie, décès ou de capitalisation:</p><p>La meilleure estimation des engagements cédés est déterminée par la formule suivante :</p><p>*BECi=BEGPi+BDFi×R0 ,  42*</p><p>où : </p><p>- *MEGPi=t>i​Ft1+rtt*, avec *rt* calculés à partir de la courbe des taux fixée par l’Autorité et *Ftt>0* les flux de trésorerie futurs probabilisés.</p><p>- *BDFi=MEGPiMEGP0×BDF0×1+rii*, avec *rt* calculés à partir de la courbe des taux fixée par l’Autorité.</p><p>- `  `*BDF0* correspond aux bénéfices discrétionnaires futurs à la date d’inventaire. - Le terme *R0* correspond au ratio de passage utilisé pour le calcul de la meilleure estimation des engagements cédés à la date d’inventaire.</p><p>**Pour les rentes découlant des opérations non-vie:**</p><p>La meilleure estimation des engagements cédés au titre de l’année de projection correspond à :</p><p>*BEC=BEGPi×R0 ,  43*</p><p>où :</p><p>- *MEGPi=t>i​Ft1+rtt*, avec *rt* calculés à partir de la courbe des taux fixée par l’Autorité et *Ftt>0* les flux de trésorerie futurs probabilisés.</p><p>- Le terme *R0* correspond au ratio de passage utilisé pour le calcul de la meilleure estimation des engagements cédés à la date d’inventaire.</p>|
|`  `Étape Nº2: Calcul des flux d’ajustement projetés|
|<p>Au titre de l’année de projection *i*, le flux d’ajustement est calculé ainsi :</p><p>*Adji=12×maxBEC-DEV+SDR;0×PD×1-PDi-1 ,  44*</p><p>avec:</p><p>- *DEV* : dépôt en espèces et en valeurs.</p><p>- *SDR* : solde de réassurance</p><p>La probabilité de défaut annuelle *PD* du cessionnaire est établie conformément au tableau prévu en ANNEXE N°2 de ce rapport .</p><p></p><p></p><p></p><p></p>|
|`  `Étape Nº3: Calcul de l’ajustement pour défaut de contrepartie|
|<p></p><p>*Adj=i>0​Adji1+rii ,  45*</p><p>avec *ri* calculés à partir de la courbe des taux fixée par l’Autorité.</p>|

- *BESC=TCS×BES* : La meilleure estimation des engagements pour sinistres cédés est évaluée en multipliant la meilleure estimation des engagements pour sinistres nets de recours par (TCS), le rapport entre la part des cessionnaires dans les provisions pour sinistres à payer et la provision pour sinistres à payer brute de réassurance.
- *BEPC=TCP×BEP* : La meilleure estimation des engagements pour primes cédés est évaluée en multipliant la meilleure estimation des engagements pour primes par le taux de cession de primes. Le taux de cession (*TCP*) de primes précité correspond au rapport entre les primes brutes non vie (cessions) et les primes émises de l’exercice.

## <a name="_toc138675083"></a>***5.3 L’ajustement pour défaut de contrepartie***
<a name="chapitre-v-part-des-cessionnaires"></a><a name="lajustement-pour-défaut-de-contrepartie"></a>En cas de réassurance, la compagnie d’assurance se confronte à un nouveau risque, celui de défaut de contrepartie. En effet, il se pourrait que les risques cédés par l’assureur ne soient pas supportés par le réassureur. Il est ainsi primordial de tenir en compte ce risque dans le calcul des meilleures estimations en effectuant un ajustement. L’ajustement pour défaut de contrepartie est déterminé en actualisant les flux d’ajustement futurs sur la base de la courbe des taux fixée par l’Autorité. Il correspond à la perte anticipée résultant de la défaillance probable du cessionnaire.

L’ACAPS propose une méthode de détermination des flux d’ajustement futurs décrite à **l’annexe N°6** de la circulaire. Cette méthode suit un certain nombre d’étapes que nous décrivons ci-après.


# <a name="_toc138675084"></a>***6. CHAPITRE VI : Capital de Solvabilité Requis***
## <a name="_toc138675085"></a>***6.1 Définition générale***
<a name="définition-générale"></a>Au cours de son existence, la compagnie d’assurance ou de réassurance fait face à plusieurs engagements dont la plupart sont risqués. Ce tas de risques encourus demande donc des préventions afin d’éviter ou de supporter leur avènement. Subséquemment, il est normal de se demandait quel montant la compagnie devrait avoir à l’instant *t* pour se couvrir des risques éventuels d’où l’introduction de la notion de Capital de Solvabilité Requis (*CSR*).

Comme son nom l’indique, le CSR correspond au capital dont a besoin une entreprise d’assurance ou de réassurance pour faire face à tous les risques qui peuvent survenir dans le futur et limiter la probabilité de ruine.

Commençons d’abord par la définition des différents risques dans les secteurs d’assurance et de réassurance pris en compte dans le projet SBR :

- **Risque de souscription** : le risque de perte ou de changement défavorable de la situation financière, en raison d’hypothèses inadéquates en matière de sinistralité, de tarification et de provisionnement.
- **Risque de marché** : le risque de perte ou de changement défavorable de la situation financière résultant, directement ou indirectement, de fluctuations affectant le niveau de la valeur des actifs, des passifs et des instruments financiers.
- **Risque de spread** (marge de crédit) : le risque de perte ou de changement défavorable de la situation financière résultant des changements touchant les marges additionnelles par rapport aux taux de référence exigée par les investisseurs sur les emprunts émis par des entités autres que l’État.
- **Risque de contrepartie** : le risque de perte ou de changement défavorable de la situation financière résultant d’un défaut de paiement d’une contrepartie ou d’une dégradation de sa qualité de crédit.
- **Risque opérationnel** : le risque de perte ou de changement défavorable de la situation financière résultant de procédures internes, de membres du personnel, de systèmes inadéquats ou défaillants, ou d’événements extérieurs.
- **Risque de concentration** : le risque de perte ou de changement défavorable de la situation financière résultant d’un manque de diversité des émetteurs auxquels l’entreprise d’assurances et de réassurance est exposée.

Tous les risques supportés par le capital de solvabilité requis sont répertoriés dans le schéma suivant :

<a name="_toc137673558"></a><a name="_toc137718607"></a><a name="_toc137915569"></a><a name="_toc137978900"></a><a name="_toc138675116"></a>**Figure 8: Présentation des risques**

|<p></p><p></p>|
| :-: |
<a name="fig-piliers"></a>Selon le circulaire de l’autorité de Contrôle des assurances et de la Prévoyance Sociale (ACAPS) le capital de solvabilité requis est constitué de la somme des éléments suivants :

- Le capital de solvabilité requis de base.
- L’exigence de capital relative au risque opérationnel.
- L’ajustement visant à tenir compte de la capacité d’absorption des pertes par les assurés.
- L’ajustement visant à tenir compte de la capacité d’absorption des pertes par les impôts différés.

*CSR=CSRB+CSRO+AdjAS+AdjID 46*

## <a name="_toc138675086"></a>***6.2 Le capital de solvabilité requis de base (CSRB)***
<a name="x996f6371680290ab18e96c29df36c0fb21384d3"></a><a name="x0beb716fe9114a411569a04c6802232189d90bd"></a>Le capital de solvabilité requis de base est le montant total des exigences de capitaux liées aux risques de **marché**, de **concentration**, de **contrepartie**, de **souscription vie** et de **souscription non-vie** et ce, après application des coefficients de corrélations.

En d’autres termes, il s’agit du montant total des capitaux nécessaires pour faire face à ces divers types de risques. Les exigences de capitaux sont évaluées individuellement pour chaque catégorie de risque, puis agrégées en appliquant les coefficients de corrélations, pour déterminer le capital de solvabilité requis de base. Cela permet aux compagnies d’assurance et de réassurance d’évaluer de manière précise les montants de capitaux nécessaires pour couvrir leurs risques spécifiques et d’assurer une solvabilité adéquate.

Le capital de solvabilité requis de base s’écrit mathématiquement comme suit:

*CSRB=i,j∈R​ρi,j\*CSRi\*CSRj ,  47*

avec :

- R *=* {Marché, Concentration, Contrepartie, Souscription Vie, Souscription Non - Vie}
- *ρ* : Coefficients de corrélations.

Jusqu’à présent, les coefficients de corrélation exactes entre les sous risques ne sont pas encore publiés par l’ACAPS, c’est pour cette raison que nous avons supposé l’indépendance entres tous ces sous risques, donc la matrice de corrélation va être de cette forme :

||Marché|Concentration|Contrepartie|Sousc. vie|Sousc. non-vie|
| :- | :- | :- | :- | :- | :- |
|Marché|1|0|0|0|0|
|Concentration|0|1|0|0|0|
|Contrepartie|0|0|1|0|0|
|Sousc. vie|0|0|0|1|0|
|Sousc. non-vie|0|0|0|0|1|


### <a name="_toc138675087"></a><a name="xcf8d4b28673d83fe23ce8914cf9f40e13d85b14"></a>**Exigence de capital relative au risque de marché (CSRM)**
Pour l’exigence de capital relative au risque de marché, il est important de prendre en compte plusieurs sous-risques tel que, les sous-risques action, taux, immobilier, écart de taux et change. Chacun de ces sous-risques présente des caractéristiques uniques et nécessite une évaluation distincte. Une fois que les exigences de capitaux déterminées pour chaque sous-risque, elles sont agrégées pour obtenir l’exigence de capital total relative au risque de marché et ce, après application des coefficients de corrélations appropriés, ce qui permet de tenir compte des interdépendances et des corrélations entre ces différents sous-risques.

L’exigence de capital relative au risque de marché peut être représentée comme suit :

*CSRM=i,j∈RM​ρi,j\*CSRi\*CSRj ,  48*

avec :

- RM *∈* {action, taux, immobilier, écart de taux et change}
- *ρ* : Coefficients de corrélations.

#### <a name="x00e0c68f46971b87c6648cfb4c5abb243b9d28f"></a>**L’exigence de capital relative au risque action (CSRA)**
Lorsqu’on parle de l’exigence de capital relative au risque action, il s’agit du montant de perte potentiel des fonds propres d’une institution financière résultant de baisses simultanées des valeurs des actions. Ce type de risque est lié à la volatilité et à la corrélation entre les différentes actions détenues dans le portefeuille d’actions.

Les taux de baisse à appliquer pour le calcul de l’exigence précitée sont fixés pour les catégories d’actions suivantes:

- Actions cotées à long terme.
- Autres actions cotées.
- Actions non cotées à long terme.
- Autres actions non cotées.
- Entités d’infrastructures.

*CSRA=BEengChoc-BEeng ,  49*

avec :

- *BECengChoc* : Best estimant des engagements après le choque de la valeur du marché des action.
- *BEeng*: Best estimant des engagements.
#### <a name="xb5fc351290b7d10916dfe69a1c5c8a08a269b48"></a>**L’exigence de capital relative au risque de taux (CSRT)**
L’exigence de capital relative au risque de taux représente le montant estimé de la perte maximale en fonds propres subit en raison de la baisse ou de la hausse des taux d’intérêt appliquées à l’ensemble de ses actifs et passifs.

l’exigence de capital relative au risque de taux est une mesure essentielle pour évaluer et gérer les risques liés aux fluctuations des taux d’intérêt. Elle contribue à assurer la stabilité financière en prévoyant une réserve adéquate pour faire face aux pertes potentielles résultant de ces variations.

La formule peut s’écrire comme suit:

*CSRT=maxCSRTH;CSRTB ,  50*

avec :

- *CSRTH*:Best estimate des engagements pour le scénario de hausse de taux,
- *CSRTB*:Best estimate des engagements pour le scénario baisse de taux,

telle que :

*CSRTB=BETB-BE*


*CSRTH=BETH-BE*

#### <a name="xeb2f88f8cd8813d75e563cba8910ca5b880a2ff"></a>**L’exigence de capital relative au risque immobilier (CSRI)**
L’exigence de capital relative au risque immobilier est la perte de fonds propres due à une baisse de la valeur des actifs immobiliers.

Cette exigence est établie pour évaluer les réserves financières nécessaires face à une potentielle baisse de valeur des biens immobiliers pour minimiser les risques.

*CSRI=BEengChoc-BEeng ,  51*

avec :

- *BEengChoc* : La meilleure estimation des engagements choqué par une baisse de la valeur des actifs immobiliers,
- *BEeng* : La meilleure estimation des engagements avant choque.

#### <a name="x26a52ae9805b11f9d1baa2a487f517d03749fc0"></a>**L’exigence de capital relative au risque d’écart de taux (CSRET)**
L’exigence de capital relative au risque d’écart de taux est la perte de fonds propres due à l’application des taux de baisse à la valeur des titres de créances non émis ou non garantis par l’État.

*CSRET=BEengChoc-BEeng ,  52*

- *BEeng* : La meilleure estimation des engagements avant choque,
- *BEengChoc* : La meilleure estimation des engagements choqué par une baisse de la valeur des titres de créances non émis ou non garantis par l’Etat.

Les taux de baisse à appliquer sont calculés en fonction de la duration et de la prime de risque à l’émission.
#### <a name="x5e99c74a71772d632d6e09c172891fadaa66da1"></a>**L’exigence de capital relative au sous-risque de change (CSRCh)**
L’exigence de capital relative au sous-risque de change correspond à la somme des exigences de capitaux pour risque de change pour chaque devise étrangère.

L’exigence de capital pour risque de change pour chaque devise étrangère correspond à la plus élevée des exigences de capitaux suivantes:

- l’exigence de capital pour risque d’augmentation de la valeur de la devise étrangère par rapport au dirham.
- l’exigence de capital pour risque de diminution de la valeur de la devise étrangère par rapport au dirham.

L’exigence de capital pour risques d’augmentation ou de diminution de la valeur de la devise étrangère par rapport au dirham est égale à la perte de fonds propres qui résulterait des scénarios d’augmentation ou de diminution, respectivement de *X%* et *X%*, de la valeur de la devise étrangère par rapport au dirham.

*CSRCh=i∈RC​CSRChi ,  53*

avec :

*RC* = {risque de change pour chaque devise étrangère }

et :

*CSRChi=maxCSRiAug ; CSRiDim*

où :

- *CSRiAug* : L’exigence de capital pour risque d’augmentation de la valeur de la devise étrangère par rapport au dirham,
- *CSRiDim* : L’exigence de capital pour risque de diminution de la valeur de la devise étrangère par rapport au dirham,

tell que:

*CSRiAug=BEAug-BE ;*

*CSRiDim=BEDim-BE ;*

en considérant :

*BEAug* : Meilleur estimation des engagement pour le scénario d’augmentation de la valeur de la devise étrangère par rapport au dirham.

*BEDim* : Meilleur estimation des engagement pour le scénario de diminution de la valeur de la devise étrangère par rapport au dirham.
### <a name="_toc138675088"></a><a name="xd0f4af3e42e2da5a32c41da94ab3029f0007a55"></a>**Exigence de capital relative au risque de contrepartie (CSRCp)**
L’exigence de capital relative au risque de contrepartie est le montant total des exigences de capitaux relatives aux sous-risques de contrepartie de type 1 et de type 2 , une fois les coefficients de corrélation appliqués.

*CSRCp=i,j∈Type​ρi,j×CSRCpi×CSRCpj ,  54*

avec :    Type = {  type 1, type 2  }
#### <a name="x303ad4190ba297cc4664f228835544b0eb3361f"></a>**Exigence de capital relative au risque de contrepartie de type 1**
L’exigence de capital relative au risque de contrepartie de type 1 est calculé en fonction des montants de pertes en cas de défaut des cessionnaires, des cédantes et des organismes dépositaires, selon la méthode décrite dans **l’annexe 9** du circulaire de l’ACAPS. Cette méthode est la suivante :

**1ère étape:** Calcul des pertes en cas de défaut des différentes contreparties *i*.

- Pour un contrat de réassurance:

*LGDi=maxX\*BEcédéei+CrC+ARi-*DEV*;0  55*

Où :

- *BECi* : La meilleure estimation des engagements cédés au cessionnaire ;
- *LGDi* : la perte en cas de défaut du cessionnaire i ;
- *DEV* : le montant des dépôts en espèces ou en valeurs du cessionnaire i ;
- *CrC* : les créances sur les cessionnaires
- *ARi* : le montant d’atténuation du risque via les différents contrats de réassurance conclus avec le cessionnaire i. Il correspond à la différence entre les montants d’exigences de capital pour les risques de souscription vie et non-vie calculés compte non tenu de la réassurance et compte tenu de la réassurance.
###### <a name="pour-un-contrat-dacceptation"></a>**Pour un contrat d’acceptation :**
*LGDi=maxDECi+CrCdi-PTi ; 0 ,  56*

où :

- *LGDi*: la perte en cas de défaut de la cédante i ;
- *DECi* : le montant des dépôts en espèces déposés chez la cédante i ;
- *CrCdi* : la Créance sur la cédante ;
- *PTi* : le montant des provisions techniques acceptées avec la cédante i ;

**Pour un avoir auprès d’un organisme dépositaire** :

*LGDi=maxABi;0  57*

où :

-*LGDi* : la perte en cas de défaut de la banque i ; 

-*AB* : L’Avoir en banque.




**2ème étape:**  Sommation des LGD par échelle de notation :

**Pour chaque échelle de notation** *k* :

*TLGDK=i​LGDk ,  58*

avec :

*i={*Contrepartie faisant partie de la même échels de notation k*}*

**3ème étape:** Calcul des volumes suivants :

*Vinter=j,k​PDk×1-PDk×PDj×1-PDjX×PDj+PDk-PDj×PDk×TLGDj×TLGDk  59*

*Vinter=j​X×PDj×1-PDjX-PDj×PDj​LGDi2*

où :

- *PDj* et*PDk*: probabilités de défaut des contreparties j et k, établies conformément aux tableaux de l’ ANNEXE N°2 ,
- *TLGDj* et *TLGDk* : somme des pertes en cas de défaut pour les contreparties dont la probabilité de défaut est, respectivement, de *PDj* et*PDk*,
- *PDj​LGDi2* : somme couvrant toutes les expositions dont la probabilité de défaut est de *PDj*.

**4ème étape:** Calcul du de la façon suivante :

*CSRCr1=X\*Vinter+Vintra;* si *Q≤x1X\*Vinter+Vintra;* si *x1≤Q≤x2i​LGDi*si *Q≥x2  60*

avec :

- *CSRCr1* : Exigence de capital relative au risque de contrepartie de type 1, tel que :

*Q=Vinter+Vintrai​LGDi .*

Les valeurs de x1, x2 et x3 ne sont pas encore publiées par l’ACAPS.
#### <a name="xde70ab66fad04d143ab07d5ec8525e6812bbe93"></a>**Exigence de capital relative au risque de contrepartie de type 2**
L’exigence de capital relative au risque de contrepartie de type 2 est le montant total des exigences de capitaux relatives aux risques de contrepartie des assurés, des intermédiaires et des autres contreparties :

*CSRCr2=CSRCrAs+CSRCrI+CSRACr ,  61*

avec :

1) *CSRCrAs*   : L’exigence de capital relative au risque de contrepartie des assurés correspond à *X%* des créances relatives aux primes ou cotisations qui demeurent impayées six (06) mois après la date de leur émission. Les créances précitées s’entendent nettes de provisions.
1) *CSRCrI* : L’exigence de capital relative au risque de contrepartie des intermédiaires correspond à *X%* des créances sur les intermédiaires d’assurances nettes de provisions.
1) *CSRACr* : L’exigence de capital relative au risque lié aux autres contreparties correspond à *X%* de la somme des créances de l’actif circulant, autres que les créances vis-à-vis de l’État des contreparties visées aux 1) et 2) ci-dessus et les montants des chèques et valeurs à encaisser, nettes de provisions et qui demeurent impayées pendant une période supérieure à six (06) mois.

*X%* est un taux qui* devrait être communiqué par l’ACAPS.
### <a name="_toc138675089"></a><a name="x15a1da03d8684dc8ce6b1dc35f3172f6a170f16"></a>**Exigence de capital relative au risque de concentration (*CSRCt*)**
L’exigence de capital relative au risque de concentration correspond à la perte des fonds propres due à la baisse des actifs associés aux ensembles d’émetteurs appartenant aux mêmes groupes.

Lorsque des émetteurs appartenant à des groupes spécifiques présentent des liens étroits et partagent des caractéristiques similaires, une baisse de la valeur de leurs actifs peut avoir un impact très important. Par conséquent, il est essentiel de prendre en compte cette concentration de risques lors de l’évaluation des réserves de capital requises.

Mathématiquement l’exigence de capital relative au risque de concentration correspond à la racine carrée de la somme des carrés des exigences de capitaux relatives au sous-risque de concentration relatifs aux différents groupes d’émetteurs.

*CSRCt=i​CSRi2 ,  62*

avec :  *i={*Les sous-risques de concentration relatifs aux différents groupes d’émetteurs*}*

Pour chaque groupe d’émetteurs, l’exigence de capital relative au risque de concentration égale à *X%* de l’écart positif constaté entre le montant des placements de l’entreprise d’assurances et de réassurance, autres que les valeurs de l’Etat ou celles jouissant de sa garantie, relatifs à l’ensemble d’émetteurs appartenant au groupe précité et *X%* du total de ses placements. Les pourcentages cités précédemment (*X%*) ne sont pas encore publiés par l’ACAPS.
### <a name="_toc138675090"></a><a name="x2470a9544a3a84f77916bd2af990c87d4d406ea"></a>**Exigence de capital relative au risque de souscription vie (*CSRSV*)**
L’exigence de capital relative au risque de souscription vie est la somme des exigences de capitaux relatives aux sous-risques de mortalité, de longévité, de rachat, de frais et de catastrophe, en appliquant les coefficients de corrélations entre ces sous-risques.

Le sous-risque de mortalité concerne les pertes potentielles découlant de décès prématurés d’un assuré, tandis que le sous-risque de longévité se rapporte aux pertes potentielles résultant d’une durée de vie plus longue que prévue. Le sous-risque de rachat concerne les pertes potentielles liées aux retraits anticipés des contrats d’assurance-vie, aussi le sous-risque de frais porte sur les pertes potentielles engendrées par les coûts administratifs associés aux contrats. Et le sous-risque de catastrophe concerne les pertes potentielles résultant d’évènements extrêmes tels que des catastrophes naturelles.

L’exigence de capital relative au risque de souscription vie permet de tenir compte des interdépendances entre ces différents sous-risques par l’applications des coefficients des corrélations entre eux, et de quantifier les réserves financières nécessaires aux compagnies d’assurance pour faire face aux pertes potentielles résultant des variations des facteurs liés à la mortalité, à la longévité, aux rachats, aux frais et aux catastrophes.

*CSRSV=i,j​ρi,j×CSRi×CSRj ,  63*

avec :     *i,j∈{*Mortalite, Longevite, Rachat, Frais, catastrophe*}*



#### <a name="x6a4c0aaf7a00518f44a130d187f964ddf1b88a9"></a>**Exigence de capital pour risque de mortalité (*CSRmort*)**
L’exigence de capital pour risque de mortalité correspond à la perte de fonds propres due à la hausse de *X%* des taux de mortalité retenus pour le calcul des provisions techniques prudentielles.

La hausse des taux de mortalité précitée ne s’applique qu’aux contrats d’assurance pour lesquels une hausse des taux de mortalité entraîne une augmentation des provisions techniques prudentielles, c’est le cas du contrat de capital décès dégressif.

*CSRmort=BEChoc-BE ,  64*

avec :

*TMChoc=TM×1+X% ,*

telle que :

` `*TM* : Taux de Mortalité avant choc.

` `*TMChoc* : Le taux de mortalité choqué par une hausse de *X%*.

le taux de choc pour la mortalité est estimé à *30%* .
#### <a name="x8575fcc7d08a11d35988144d33aa87c665af295"></a>**Exigence de capital pour risque de longévité (*CSRLon*)**
L’exigence de capital pour risque de longévité correspond à la perte de fonds propres qui résulterait de la baisse de *X%* des taux de mortalité retenus pour le calcul des provisions techniques prudentielles.

La baisse des taux de mortalité précitée ne s’applique qu’aux contrats d’assurance pour lesquels une baisse des taux de mortalité entraîne une augmentation des provisions techniques prudentielles.

*CSRLon=BEChoc-BE  65*

avec :

*TMChoc=TM×1-X% ,*

` `*TM* : Taux de Mortalité.

` `*TMChoc* : Le taux de mortalité choqué par une hausse de X%.

#### <a name="xf9593f399cde8ef9ae9c140ec93b1cb9af95941"></a>**Exigence de capital pour risque de rachat (*CSRR*) :**
Qu’est-ce qu’un rachat en assurance vie ? Un rachat en assurance vie est un retrait d’une partie ou de la totalité de l’épargne placée sur un contrat d’assurance vie. Le rachat peut être total ou partiel, ponctuel ou programmé. Le rachat entraîne des conséquences fiscales qui dépendent de la durée du contrat et de la date des versements. Le rachat peut être soumis à l’impôt sur le revenu, au prélèvement forfaitaire libératoire ou au prélèvement forfaitaire unique, ainsi qu’aux prélèvements sociaux. Le rachat n’est pas possible si le bénéficiaire du contrat a accepté le bénéfice sans l’accord du souscripteur.

On distingue :

- **Le rachat partiel** : les assurés peuvent récupérer une fraction de la valeur du contrat qui sera constituée d’une part de capital et d’une part d’intérêts capitalisés s’ils ont par exemple besoin de liquidités pour un projet précis. Le rachat partiel permet de ne pas mettre un terme au contrat et de ne pas perdre l’antériorité fiscale.
- **Le rachat total** : les assurés peuvent récupérer l’intégralité de la valeur de rachat de leur assurance vie, et leur contrat prend fin, entraînant la perte de l’antériorité fiscale.

L’exigence de capital pour risque de rachat correspond au maximum entre les exigences de capitaux suivantes:

- L’exigence de capital pour risque de hausse des taux de rachat : cette exigence signifie la perte de fonds propre qui résulterait d’une revalorisation des provisions techniques prudentielles suite à une hausse de *X%* des taux de rachat retenus, en montant et en nombre. Toutefois, les taux de rachat augmentés de la hausse précitée ne doivent pas dépasser *X%*.

La hausse des taux de rachat précitée ne s’applique qu’aux contrats d’assurance pour lesquels une hausse des taux de rachat entraîne une augmentation des provisions techniques prudentielles.

- L’exigence de capital pour risque de baisse des taux de rachat : cette exigence correspond à la perte de fonds propre qui résulterait d’une revalorisation des provisions technique prudentielles due à une baisse de X% des taux de rachat retenus, en montant et en nombre.

La baisse des taux de rachat précitée ne s’applique qu’aux contrats d’assurance pour lesquels une baisse des taux de rachat entraîne une augmentation des provisions techniques prudentielles.

*CSRR=maxCSRRHT;CSRRBT ,  66*

avec :

*CSRRHT=BERHT-BECSRRBT=BERBT-BE*

tell que :

*BERHT* : Meilleur estimation des engagements pour le scenario d’une hausse des taux de rachat. *BERBT* : Meilleur estimation des engagements pour le scenario d’une baisse des taux de rachat.
#### <a name="x3f53d97ac0100081bf14cce1c7c4c7b66f159ab"></a>**Exigence de capital relative au risque de frais (*CSRF*)**
L’exigence de capital relative au risque de frais correspond à la perte de fonds propres due à des augmentations combinées de :

- *X* du montant de frais de gestion unitaire moyen retenu pour le calcul des provisions techniques prudentielles des opérations d’assurance vie, décès ou de capitalisation et des rentes découlant des opérations non-vie et ce, par sous-catégorie;
- *X* par année de projection du montant de frais de gestion unitaire moyen précité.

*CSRF=BEFChoc-BEF  67*

Les taux *X%* ne sont pas encore publiés par l’ACAPS.
#### <a name="xc425fc38e0e5ab3433dbb608f017e66bae918da"></a>**Exigence de capital relative au risque de catastrophe (*CSRCat*)**
L’exigence de capital relative au risque de catastrophe vie correspond à l’application d’un coefficient des capitaux sous risque relatifs aux garanties en cas de décès nets de réassurance.

*CSRCat=BEChoc-BE ,  68*

avec :

- *BEChoc* : Meilleure estimation après le choc par un coefficient X%, ce taux est estimé à *0,2%*,
- *BE*: Meilleure estimation sans aucun choc.



### <a name="_toc138675091"></a><a name="xbd0ac9d5bee7e5f803a71cc891308fb216ea9f5"></a>**Exigence de capital relative au risque de souscription non vie (*CSRSNV*)**
L’exigence de capital relative au risque de souscription non-vie est la somme totale des exigences de capitaux relatives aux , une fois les coefficients de corrélation appliqués.

*CSRSNV=i,j​ρi,j×CSRi×CSRj ,  69*

avec :

*i,j∈{*Primes, Provisions, Catastrophe*}*

*ρ* : le coefficient de corrélation.
#### <a name="xae7d56ebf3941082763747c73c9ac177ca68057"></a>**Exigence de capital relative au sous-risque de primes (*CSRP*)**
L’exigence de capital relative au sous-risque de primes est le montant total des exigences de capitaux relatives aux sous-risques de primes par sous-catégorie et ce, après application des coefficients de corrélations.

*CSRP=i,j​ρi,j×CSRi×CSRj ,  70*

avec :

*i,j∈{*Les sous-risques de primes par sous-categorie *}*

*ρ* : le coefficient de corrélation entre les sous-catégories des sous-risques de primes.

Pour chaque sous-catégorie, l’exigence de capital afférente au sous risque de primes est égale à X fois le produit de l’écart-type de primes et du montant des primes acquises augmenté de la provision pour primes non-acquises nettes de réassurance au titre de l’exercice inventorié.

*CSRP*sous-categorie*=X×σP×P ,*

avec :

*P=PA+PPNA ,*

telle que :

- *P*: Primes,
- *PA* : Primes acquises nettes,
- *PPNA* : Provision pour primes non-acquises nettes.
#### <a name="x533f7701cb3661cf34b00dcb745118a22053996"></a>**Exigence de capital relative au sous-risque de provisions (*CSRPr*)**
L’exigence de capital relative au sous-risque de provisions est la somme total des exigences de capitaux relatives aux sous-risques de provision par sous-catégorie, en prenant en considération les coefficients de corrélation entre les sous-risques.

*CSRPr=i,j​ρi,j\*CSRi\*CSRj ,  71*

avec :

*i,j∈{*Les sous-risques de provisions par sous-categorie*}*.

*ρ* : le coefficient de corrélation entre les sous-catégories des sous-risques de provisions.

Pour chaque sous-catégorie, l’exigence de capital afférente au sous risque de provision est égale à X fois le produit de l’écart-type de provisions et du montant de la meilleure estimation des engagements pour sinistres nette de réassurance.

*CSRPr*sous-categorie*=X%×σPr×BEeng*
#### <a name="x59b87b9c1564dfa6327f8096dc87cc44d59238b"></a>**Exigence de capital relative au risque de catastrophe non-vie (*CSRCat*)**
L’exigence de capital relative au risque de catastrophe non-vie correspond au racine carrée de la somme des carrés des exigences de capitaux relatives au sous-risque de catastrophe non-vie des garanties suivantes :

- Individuelles accidents et Invalidité ;
- Maladie;
- Accidents du travail et maladies professionnelles ;
- Responsabilité civile automobile des véhicules terrestres à moteur;
- Responsabilité civile (autre que la responsabilité civile automobile et la responsabilité civile résultant de l’emploi de véhicules fluviaux ou maritimes ou de l’emploi des aéronefs) ;
- Incendie ;
- Maritime corps, facultés et responsabilité civile résultant de l’emploi de véhicules fluviaux et maritimes ;
- Aviation corps et responsabilité civile résultant de l’emploi des aéronefs ;
- Marchandises transportées par voie terrestre ;
- Assurance récolte, grêle ou gelée et éléments naturels ;
- Crédit et caution;

*CSRCat=i​CSRi2 ,  72*

telle que, le *i* Appartient à la liste des garanties ci-dessus.
### <a name="_toc138675092"></a><a name="xd14d4909bf7dda0b454a4d63bb1103fca6ae0cc"></a>**Exigence de capital relative au risque opérationnel (*CSRO*)**
L’exigence de capital relative au risque opérationnel correspond à X% du capital de solvabilité requis de base.

*CSRO=X%\*CSRB   73*

avec *X%* fixé par l’autorité et *CSRB* le capital de solvabilités requis de base.
### <a name="_toc138675093"></a><a name="x384c0c3c983e0c0cecb046cfdf19f3cf5bf77b3"></a>**Ajustement du capital de solvabilité requis**
#### <a name="xe8f4b96a75672450572e77d9119309d136820dc"></a>**Ajustement visant à tenir compte de la capacité d’absorption des pertes par les assurés (*AdjAs*)**
L’ajustement visant à tenir compte de la capacité d’absorption des pertes par les assurés égale au minimum de l’écart entre le capital de solvabilité requis de base calculées brutes et nettes d’absorption par les assurés, d’une part, et le montant des bénéfices discrétionnaires futures d’autre part.

*AdjAs=minCSRBnette-CSRBbrute;BDF ,  74*

avec : *AdjAs* : Ajustement pour tenir compte la capacité d’absorption des pertes par les assurés.

#### <a name="x853db30fa69a09c5e04203c4cd1553c315569bc"></a>**Ajustement visant à tenir compte de la capacité d’absorption des pertes par les impôts différés (*AjtID*)**
L’ajustement visant à tenir compte de la capacité d’absorption des pertes par les impôts différés correspond au produit du taux d’impôts et le minimum de la somme du capital de solvabilité requis de base et l’exigence de capital relative au risque opérationnel diminuée de l’ajustement visant à tenir compte de la capacité d’absorption des pertes par les assurés, d’une part, et l’écart positif entre les impôts différés-passif et les impôts différés-actif, d’autre part.

<a name="eq-gbmp"></a>*AjtID=TI×minCSRB+CSRO-AdjAs ; IDp-IDa ,  75*

avec :

- *AjtID* : Ajustement pour tenir compte de la capacité d’absorption des pertes par les impôts différés,
- *TI* : aux d’Impôts,
- *IDa* : Les impôts différés-passif,
- *IDp* : Les impôts différés-actif.


|`  `**Remarque**|
| :- |
|Dans le cas où l’écart entre les impôts différés-passif et les impôts différés-actif est négatif, l’ajustement précité est nul.|


# <a name="_toc138675094"></a>***7. CHAPITRE VII : Application numérique de la Solvabilité Basée sur les Risque***
## <a name="_toc138675095"></a>***7.1 Modèle LSTM appliqué au cours de l’indice MASI***
<a name="sec-rnn_app"></a>Ce code est utilisé pour créer et entraîner un modèle de réseaux de neurones récurrents (RNN) appelé Long Short-Term Memory (LSTM) pour prédire le dernier cours de l’indice MASI à partir des données historiques.

Voici une explication étape par étape du code source disponible en **ANNEXE Nº1**:

1. Les bibliothèques nécessaires sont importées, notamment pandas pour la manipulation des données, matplotlib pour la visualisation des résultats, et TensorFlow pour la création et l’entraînement du modèle LSTM.
1. Le fichier CSV contenant les données historiques est lu à l’aide de la fonction **pd.read\_csv()**, et les données sont stockées dans un DataFrame appelé **df**.
1. Deux fonctions, **convert\_num()** et **pct\_to\_num()**, sont définies pour convertir les valeurs des colonnes en nombres. La première fonction est utilisée pour enlever les espaces, les points et les virgules et convertir les valeurs en nombres décimaux. La deuxième fonction est utilisée pour enlever les espaces, les virgules et les signes de pourcentage, puis convertir les valeurs en nombres décimaux.
1. Les fonctions de conversion sont appliquées aux colonnes appropriées du DataFrame à l’aide de la méthode **applymap()**.
1. Les données sont préparées pour l’entraînement du modèle. Les colonnes pertinentes du DataFrame (**Dernier**, **Ouv.**, **Plus Haut**, **Plus Bas**) sont extraites et converties en tableaux NumPy. Les données sont ensuite normalisées à l’aide de la classe **MinMaxScaler** de scikit-learn, ce qui les met à l’échelle entre 0 et 1.
1. Des séquences de données sont créées pour l’entraînement du modèle. Chaque séquence contient les 5 observations précédentes en tant qu’entrée et la valeur du cours “Dernier” à la prochaine observation en tant que sortie. Cela permet d’entraîner le modèle à prédire le cours futur en fonction des observations passées.
1. Les données sont divisées en ensembles d’entraînement et de test. **95%** des données sont utilisées pour l’entraînement et **5%** sont réservées pour les tests.
1. Le modèle LSTM est défini à l’aide de la classe **Sequential** de Keras. Il est composé de trois couches LSTM avec une couche de dropout entre chaque couche pour éviter le surapprentissage. La dernière couche est une couche dense avec une seule unité qui prédit la valeur du cours “Dernier”.
1. Le modèle est compilé avec l’optimiseur Adam et la fonction de perte “mean\_squared\_error” pour mesurer l’erreur de prédiction.
1. Le modèle est entraîné sur les données d’entraînement à l’aide de la méthode **fit()**. Le nombre d’époques est défini à 100 et la taille du lot est définie à 30.
1. Le modèle est utilisé pour faire des prédictions sur les données de test à l’aide de la méthode **predict()**. Les prédictions sont inversées à l’échelle originale à l’aide de la méthode **inverse\_transform()** de l’objet **scaler**.
1. L’erreur de prédiction est évaluée en calculant la racine carrée de l’erreur quadratique moyenne (RMSE) entre les valeurs de test réelles et les valeurs prédites.
1. Les valeurs réelles et prédites sont tracées à l’aide de la bibliothèque matplotlib pour visualiser les performances du modèle.

En résumé, ce code utilise un modèle LSTM pour prédire le dernier cours du MASI à partir des données historiques, puis évalue les performances du modèle en calculant l’erreur de prédiction et en traçant les résultats. On observe que les cours prédits sont étroitement proches des cours observés attestant ainsi la performance du modèle.

<a name="_toc137673559"></a><a name="_toc137718608"></a><a name="_toc137915570"></a><a name="_toc137978901"></a><a name="_toc138675117"></a>**Figure 9: Courbe de cours prédit et de cours observé**

|<p></p><p></p>|
| :-: |
## <a name="fig-prediction_masi2"></a><a name="_toc138675096"></a>***7.2 Application de calcul des CSR***
<a name="xdfd4d006d9124550c85001a73cc2cd266d3535f"></a><a name="application-de-calcul-des-csr"></a>Dans le cadre de ce projet, nous avons développé une application permettant de calculer les capitaux de solvabilité requis. Ce calcul passe par plusieurs étapes c’est pourquoi l’application contient plusieurs onglets :

- **Paramètres** : les paramètres généraux de l’application; \_ **Courbe des taux** : construction de la courbe des taux zéro coupon; \_ **Non-vie hors rentes** : calcul des meilleures estimations pour une opération d’assurance non vie hors rente (***exemple de l’accident de travail AT***);
- **Assurance vie** : calcul des meilleures estimations pour une opération d’assurance vie (exemple d’un capital garanti dégressif en cas de décès).

<a name="_toc137673560"></a><a name="_toc137718609"></a><a name="_toc137915571"></a><a name="_toc137978902"></a><a name="_toc138675118"></a>**Figure 10: Onglets de l’application**

||
| :-: |
<a name="fig-onglets"></a>Cette application a été développée grâce à [**Shiny**](https://shiny.posit.co/) et une de ses extensions [**bs4dash**](https://rinterface.github.io/bs4Dash/index.html). En guise d’information, Shiny est un package R qui facilite la création d’applications Web interactives directement à partir de R. Vous pouvez héberger des applications autonomes sur une page Web ou les intégrer dans des documents R Markdown ou créer des tableaux de bord. Vous pouvez également étendre vos applications Shiny avec des thèmes CSS, des widgets html et des actions JavaScript, d’où l’intervention de {bs4Dash} dans ce projet. Il permet quant à lui de créer des tableaux de bord Shiny avec la technologie Bootstrap 4. Le choix du langage R pour développer cette application est motivé par la simplicité du package shiny et de plus ce langage nous est déjà familier puisque c’est l’un des plus utilisés en sciences de données.

L’application est une agglomération de codes et de calculs, son utilisation nécessite alors de claires indications.


### <a name="_toc138675097"></a><a name="navigation-dans-le-code-source"></a>**Navigation dans le code source**
Le dossier de l’application contient trois fichiers principaux d’extension “.R”. Le premier nommé app.R contient la partie ui (user interface) et server de l’application. Le second, functions.R détient l’ensemble des fonctions que nous avons programmées et qui sont requis dans le fichier app.R. Le dernier fichier sert à automatiser l’installation de tous les packages nécessaire pour faire tourner l’application et nous l’avons nommé installation packages.R.

Les commentaires ont été faits de sorte à faciliter la navigation. Peu importe le fichier, vous pouvez commencer par contracter votre code comme indiqué dans la [**Figure 11**](#fig-app_r). Cette dernière est celle du code contracté du fichier app.R. Comme vous pouvez le constater, les titres sont assez significatifs. Vous pouvez donc étendre la partie qui vous intéresse pour avoir accès au code. Cette astuce, simple qu’elle puisse paraître, est très utile pour naviguer dans le code source sachant que le nombre de lignes est pléthoriques.

<a name="_toc137673561"></a><a name="_toc137718610"></a><a name="_toc137915572"></a><a name="_toc137978903"></a><a name="_toc138675119"></a>**Figure 11:  Fichier app.R**

||
| :-: |
### <a name="fig-app_r"></a><a name="_toc138675098"></a><a name="paramètres"></a>**Paramètres**
Cet onglet est dédié à la spécification de certains paramètres de la normes SBR. Nous avons donné des valeurs par défaut puisque l’ACAPS n’a toujours pas quantifié de manière officielle ces paramètres. Dans cet onglet on trouve :

- **Choc de mortalité** : représente le taux de choc de mortalité que nous avons fixé à *30%*\*.
- **Choc de catastrophe** : taux de hausse de la mortalité due à une catastrophe naturelle. Ce taux est fixé par défaut à**  *0,2%*\*. Par catastrophe naturelle, on sous-entend une circonstance particulière telle qu’une épidémie, un tremblement de terre etc.,
- **Probabilité de défaut** : représente la probabilité de défaut des cessionnaires. Nous avons pris la valeur de *1,2%***\*** qui est la probabilité de défaut moyenne des réassureurs sur le marché,
- **Cession vie** : est le taux de cession des engagements dans le cadre de l’opération d’assurance vie. Ce paramètre dépend du traité de réassurance, autrement dit c’est une entrée définie par l’utilisateur de l’application et non par l’ACAPS. Le taux de cession observé pour cette branche sur le marché marocain est de *1%*

- **Cession primes non-vie** : taux de cession des primes dans l’opération d’assurance non vie qui vaut *5%***\*,**
- **Cession sinistres non-vie** : taux de cession des sinistres dans l’opération d’assurance non vie qui vaut *3%***\***,
- **Augmentation des FG** : taux d’augmentation des frais de gestions valant par défaut dans notre application *14%***\*;**
- **Majoration des FG** : taux de majoration des frais de gestions qui correspond au taux d’augmentation annuelle pour les années de projection. Il vaut *1,5%***\***;

<a name="_toc137673562"></a><a name="_toc137718611"></a><a name="_toc137915573"></a><a name="_toc137978904"></a><a name="_toc138675120"></a>**Figure 12: Aperçu de l’onglet paramètre**

|<p></p><p></p>|
| :-: |
### <a name="fig-parametres"></a><a name="_toc138675099"></a><a name="courbe-des-taux"></a>**Courbe des taux**
La construction de la courbe des taux zéro coupon est une étape cruciale du calcul de CSR. Nous avons inclus ce processus décrit à la [**Section 2.1**](#sec-courbe_zc). L’application donne la main à l’utilisateur de saisir une date de valeur, le 30 décembre 2022 pour notre étude. Cette date n’est rien d’autre que la date d’inventaire.

<a name="_toc137673563"></a><a name="_toc137718612"></a><a name="_toc137915574"></a><a name="_toc137978905"></a><a name="_toc138675121"></a>**Figure 13: Sélection de la date de valeur**

|<p></p><p></p>|
| :-: |
<a name="fig-date_zc"></a>Ensuite, l’application se charge de télécharger automatiquement la table des taux des bons de références disponibles sur le site de la Banque Centrale BAM. Cette table est alors utilisée pour faire une interpolation afin de trouver les taux correspondant aux maturités pleines. On utilise ces derniers pour calculer d’abord les taux actuariels et par ricochet les taux zéro coupon. Dans cet onglet, on peut trouver les différentes étapes suivies pour la construction de la courbe des taux zéro coupon, du téléchargement des données au boostraping. De plus, toutes les tables sont exportables sous format pdf, excel, ou csv.

<a name="_toc137673564"></a><a name="_toc137718613"></a><a name="_toc137915575"></a><a name="_toc137978906"></a><a name="_toc138675122"></a>**Figure 14: Aperçu de la courbe des taux zéro-coupon dans l’application**

||
| :-: |
<a name="fig-tzc_app"></a> 

<a name="_toc137673565"></a><a name="_toc137718614"></a><a name="_toc137915576"></a><a name="_toc137978907"></a><a name="_toc138675123"></a>**Figure 15: Zoom sur la courbe de taux zéro coupon (En bleue)**

|<p></p><p></p>|
| :-: |
<a name="fig-tzc"></a>Une fois la courbe construite, nous allons l’utiliser dans la suite de notre application pour le calcul des tous les flux futurs actualisés dont nous aurons besoin.
### <a name="_toc138675100"></a><a name="opérations-dassurance-non-vie-hors-rente"></a>**Opérations d’assurance non-vie hors rente**
Pour cette opération, l’entreprise d’accueil a mis à notre disposition une base de données sur l’assurance Accident de Travail (AT). Il s’agit d’un triangle de règlements cumulés d’une assurance AT (voir la [**Section 4.4.1.4**](#sec-ladder)).

<a name="tbl-triangleat"></a><a name="_toc137673499"></a><a name="_toc137673648"></a><a name="_toc137718707"></a><a name="_toc137915590"></a><a name="_toc138675137"></a>**Table 6: Triangle de règlements cumulés d’une assurance AT**

| |0|1|2|3|4|5|6|7|8|9|10|
| :- | -: | -: | -: | -: | -: | -: | -: | -: | -: | -: | -: |
|2012|3 504,00|17 838,65|29 762,13|37 354,13|48 113,13|54 288,92|60 990,92|64 953,92|67 075,06|67 961,14|69 073,14|
|2013|4 774,24|14 225,85|24 891,85|38 451,85|45 605,98|54 219,98|57 611,98|61 752,56|62 906,74|64 306,33| |
|2014|3 821,92|12 489,92|28 284,92|39 782,63|46 485,63|51 429,63|53 462,05|54 797,99|55 771,01| | |
|2015|4 074,00|19 021,00|35 729,00|50 865,00|58 417,00|62 138,27|63 510,56|64 673,57| | | |
|2016|5 070,00|19 512,00|41 560,00|51 917,00|59 168,44|66 278,59|69 647,56| | | | |
|2017|3 817,00|17 940,00|27 339,00|33 666,67|37 893,96|41 649,41| | | | | |
|2018|7 838,00|23 756,00|34 489,85|42 665,27|51 181,77| | | | | | |
|2019|7 690,00|29 440,55|43 027,97|56 870,69|` `0,00| | | | | | |
|2020|8 935,00|27 985,56|42 675,50| | | | | | | | |
|2021|4 979,97|21 154,81|` `0,00| | | | | | | | |
|2022|5 818,64| | | | | | | | | | |

Notre application donne à l’utilisateur l’option de sélectionner manuellement le triangle, au cas où ce dernier n’est pas cumulé, l’utilisateur peut cocher sur la case « Voulez-vous cumuler le triangle ? » avant de confirmer la lecture (voir [**Figure 16**](#fig-import)). Les autres paramètres de cette fenêtre sont des paramètres généraux d’importation de données dans commun à tous les langages de programmation.

<a name="_toc137673566"></a><a name="_toc137718615"></a><a name="_toc137915577"></a><a name="_toc137978908"></a><a name="_toc138675124"></a>**Figure 16: Importation du triangle**

|<p></p><p></p>|
| :-: |
<a name="fig-import"></a>En plus du triangle, cet onglet de l’application a besoin des données d’entrée telles que :

- **Primes Acquises (PA)** : nécessaire pour le calcul du ratio de sinistralité qui pour rappel vaut *RS=i=n-2nCUii=n-2nPAi* où CU représente les charges ultimes.
- **PPNA** : provision pour primes non acquises à la date d’inventaire.
- **Primes futurs** : le montant unique des primes futurs.
- **Taux de frais d’acquisition** : Le taux de frais d’acquisition en assurance est le pourcentage de frais prélevé par l’assureur sur chaque versement effectué par l’assuré.
- **Taux de frais gestion moyens.**

La [**Figure 17**](#fig-parametrage) donne un aperçu de l’endroit où ces paramètres sont requis et le [**Table 7**](#tbl-parametrage) représente les données historiques de PA et PPNA dont nous avons besoin.

<a name="_toc137673567"></a><a name="_toc137718616"></a><a name="_toc137915578"></a><a name="_toc137978909"></a><a name="_toc138675125"></a>**Figure 17: Aperçu du paramétrage dans l’application**

|<p></p><p></p>|
| :-: |

<a name="fig-parametrage"></a><a name="tbl-parametrage"></a><a name="_toc137673500"></a><a name="_toc137673649"></a><a name="_toc137718708"></a><a name="_toc137915591"></a><a name="_toc138675138"></a>**Table 7: Données de PA et PPNA**

|**Année**|**PA**|**PPNA**|
| -: | -: | -: |
|2020|86292|NA|
|2021|133944|NA|
|2022|115787|25000|

L’application supporte le calcul des meilleures estimations des engagements une fois tous les paramètres de cet onglet sont renseignés.
##### <a name="x2b8ae77a89950f896ef9c1423091d64484114bd"></a>**Meilleure estimation des engagements pour sinistres avec Chain Ladder**
**Hypothèse N°1 :**

L’hypothèse d’indépendance, suppose que les paiements de sinistres sont indépendants les uns des autres, ce qui signifie que le montant d’un sinistre ne dépend pas des montants des autres sinistres.

Pour la vérification de cette hypothèse, Nous avons tracé les facteurs de développement *fi,j* individuel pour chaque année de développement *j* en fonction de toutes les années de survenance *i*, et on a comparé la moyenne de facteur de développement individuel.

Les facteurs de développement individuels relatif à une année de développement *j* doivent être significativement proche de la moyenne des facteurs de développement individuels sur ladite année pour que la première hypothèse soit vérifiée.

<a name="_toc137915579"></a><a name="_toc137978910"></a><a name="_toc138675126"></a>**Figure 18: Vérification de l’hypothèse N°1 sur les années de développement**

|<p></p><p></p>|
| :-: |
|<p><a name="_toc137915580"></a><a name="_toc137978911"></a><a name="_toc138675127"></a>**Figure 19: Vérification de l’hypothèse N°1 sur les années de développement**</p><p></p><p></p>|
On peut constater que les *fi,j* sont à peu près alignés autour des *fj* ce qui nous pousse a validé la première hypothèse de Chian Ladder.

**Hypothèse N°2 :**

L’hypothèse de linéarité dans la méthode de Chain-Ladder suppose que les sinistres évoluent de manière constante et prévisible au fil du temps. Cela signifie que la tendance observée dans les paiements de sinistres passés se poursuivra sans changement significatif à l’avenir.

Pour vérifier cette hypothèse, on a tracé les montants des règlements cumulés de chaque année de développement en fonction de l’année de développement précédant, et on a contrôlé s’il y a une linéarité entre ces deux années. Le nuage de points représentant les règlements cumulés d’une année *j* par rapport aux règlements cumulés de l’année *j-1* doit être approché significativement par une droite.

|<p><a name="_toc137915581"></a><a name="_toc137978912"></a><a name="_toc138675128"></a>***Figure 20: Vérification de l’hypothèse N°1 sur les années de développement***</p><p></p><p></p>|
| :-: |

On remarque bien, que pour toutes les années de développement, il y a une sorte de linéarité entre les années de développements. Ce qui prouve la deuxième hypothèse.

En suivant les étapes mentionnées à la [**Section 4.4.1.4**](#sec-ladder), on a obtenu les facteurs de développements présenté dans le tableau [**Table 8**](#tbl-fdev).

<a name="tbl-fdev"></a><a name="_toc137673501"></a><a name="_toc137673650"></a><a name="_toc137718709"></a><a name="_toc137915592"></a><a name="_toc138675139"></a>**Table 8: Les facteur de développements**

|**fdc1**|**fdc2**|**fdc3**|**fdc4**|**fdc5**|**fdc6**|**fdc7**|**fdc8**|**fdc9**|**fdc10**|
| -: | -: | -: | -: | -: | -: | -: | -: | -: | -: |
|3\.7312|1\.689|1\.3263|1\.177|1\.1161|1\.0585|1\.045|1\.0234|1\.0176|1\.0164|

Ces facteurs sont ensuite utilisés pour remplir le triangle inférieur par la méthode de Chaine Ladder pour obtenir les règlements futurs ([**Table 9**](#tbl-regf)) cumulés dont la dernière colonne représente les charges ultimes.

<a name="tbl-regf"></a><a name="_toc137673502"></a><a name="_toc137673651"></a><a name="_toc137718710"></a><a name="_toc137915593"></a><a name="_toc138675140"></a>**Table 9: Règlements futurs cumulées**

| |0|1|2|3|4|5|6|7|8|9|10|
| :- | -: | -: | -: | -: | -: | -: | -: | -: | -: | -: | -: |
|2011|3 504,00|17 838,65|29 762,13|37 354,13|48 113,13|54 288,92|60 990,92|64 953,92|67 075,06|67 961,14|69 073,14|
|2012|4 774,24|14 225,85|24 891,85|38 451,85|45 605,98|54 219,98|57 611,98|61 752,56|62 906,74|64 306,33|65 358,53|
|2013|3 821,92|12 489,92|28 284,92|39 782,63|46 485,63|51 429,63|53 462,05|54 797,99|55 771,01|56 751,72|57 680,30|
|2014|4 074,00|19 021,00|35 729,00|50 865,00|58 417,00|62 138,27|63 510,56|64 673,57|66 187,34|67 351,21|68 453,23|
|2015|5 070,00|19 512,00|41 560,00|51 917,00|59 168,44|66 278,59|69 647,56|72 782,18|74 485,74|75 795,54|77 035,73|
|2016|3 817,00|17 940,00|27 339,00|33 666,67|37 893,96|41 649,41|44 085,75|46 069,91|47 148,24|47 977,31|48 762,33|
|2017|7 838,00|23 756,00|34 489,85|42 665,27|51 181,77|57 122,55|60 464,00|63 185,29|64 664,23|65 801,32|66 877,98|
|2018|7 690,00|29 440,55|43 027,97|56 870,69|66 936,99|74 706,50|79 076,55|82 635,54|84 569,73|86 056,85|87 464,94|
|2019|8 935,00|27 985,56|42 675,50|56 599,12|66 617,36|74 349,77|78 698,95|82 240,95|84 165,90|85 645,92|87 047,28|
|2020|4 979,97|21 154,81|35 731,44|47 389,45|55 777,54|62 251,75|65 893,24|68 858,89|70 470,62|71 709,81|72 883,15|
|2021|5 818,64|21 710,35|36 669,78|48 633,93|57 242,31|63 886,54|67 623,65|70 667,19|72 321,24|73 592,98|74 797,13|

On en déduit facilement les flux de règlements futurs en faisant la sommes des éléments du triangle inférieur décumulé. Par suite, on obtient les cashflows pour les 10 années de projections suivants :

<a name="tbl-cash"></a><a name="_toc137673503"></a><a name="_toc137673652"></a><a name="_toc137718711"></a><a name="_toc137915594"></a><a name="_toc138675141"></a>**Table 10: Flux de règlements futurs (Cafh Flows)**

|Année|Flux de règlements futurs nets de recours|
| -: | -: |
|2023|69516\.673|
|2024|53526\.816|
|2025|38666\.143|
|2026|26538\.953|
|2027|17684\.015|
|2028|11191\.502|
|2029|7543\.367|
|2030|4294\.611|
|2031|2445\.069|
|2032|1204\.150|

Une actualisation des cash flows de la [**Table 10**](#tbl-cash) par la courbe des taux zéro coupon s’opère automatiquement par l’application pour effectuer le calcul de la meilleure estimation des engagements pour sinistres :

*BES=213 799* MAD




##### <a name="xec76dcf86b3294f48a9bca8d3a72733b31834ca"></a>**Meilleure estimation des engagements pour prime (BEP)**
Pour le calcul de la *BEP*, nous avons besoin du ratio de sinistralité (*RS=i=n-2nCUii=n-2nPAi*). Notre application calcule ce ratio à partir des PA données en input puisque nous disposons déjà des charges ultimes, qui, nous le rappelons, correspondent aux éléments de la dernière colonne de la [**Table 9**](#tbl-regf). Ainsi nous obtenons les paramètres suivants :

|**Paramètre**|**Valeur**|
| :- | :- |
|RS|0,698546111|
|PPNA|25000|
|Primes futurs|100000|
|Taux de frais d'acquisition|0,1|

Après détermination des cadences de liquidation, nous trouve comme meilleure estimation des engagements pour prime :

*BEP=-16 907* MAD

Ce résultat négatif s’explique par le montant des primes futurs. En effet, du fait que cette prime soit unique et importante, au moment de l’inventaire, l’assureur a encaissé plus qu’il ne doit décaisser d’ici 10 ans pour les engagements correspondants. Par conséquent, puis que la meilleure estimation correspond à la différence entre les décaissements et les encaissements, alors c’est pourquoi la *BEP* est négative.

<a name="_toc137718712"></a><a name="_toc137915595"></a><a name="_toc138675142"></a>***Table 11: Cadence de liquidation par année de développement***

|**Cad.0**|**Cad.1**|**Cad.2**|**Cad.3**|**Cad.4**|**Cad.5**|**Cad.6**|**Cad.7**|**Cad.8**|**Cad.9**|**Cad.10**|
| :- | :- | :- | :- | :- | :- | :- | :- | :- | :- | :- |
|7,78%|21,25%|20,00%|16,00%|11,51%|8,88%|5,00%|4,07%|2,21%|1,70%|1,61%|



|<p></p><p>**Output des cadences de liquidations dans l’application**</p>|
| :-: |
##### <a name="x2013334023ad673b57272bdd191af21a92b46a7"></a>**Meilleure estimation des frais de gestions (BEFG)**
Le taux moyen des trois dernières années des frais de gestions étant de *3%*, on aboutit au résultat :

*BEFG=59 067* MAD

|<p></p><p>**Affichages des BE dans l’application**</p>|
| :-: |
### <a name="_toc138675101"></a><a name="opérations-dassurance-vie"></a>**Opérations d’assurance vie**
Dans ce projet nous avons étudié le cas d’un capital décès dégressif. Ce dernier est un type de capital versé aux bénéficiaires d’une assurance décès qui diminue progressivement avec le temps, jusqu’à atteindre un capital nul. Ce type de capital est utile pour couvrir un besoin financier important lors des premières années de l’assurance (hypothèque, crédit, enfants à charge, etc.) et qui diminue au fil du temps. Comme dans le cas du triangle, l’utilisateur de notre application peut parcourir son ordinateur afin de sélectionner la table de données qui doit contenir au moins les colonnes suivantes :

- **Age de l’assuré**,
- **Année d’effet du contrat**,
- **Durée du contrat**,
- **Durée restante du contrat**,
- **Le capital initial**.

L’utilisateur doit sélectionner les colonnes mentionner sous-dessus puis renseigné les frais de gestions unitaire moyen qui est de *100* pour notre étude.

<a name="_toc137673568"></a><a name="_toc137718617"></a><a name="_toc137915582"></a><a name="_toc137978913"></a><a name="_toc138675129"></a>**Figure 21: Importation des données (Capital Décès Dégressif)**

|<p></p><p></p>|
| :-: |
<a name="fig-dec_import"></a> 

<a name="tbl-dec_table"></a><a name="_toc137673504"></a><a name="_toc137673653"></a><a name="_toc137718713"></a><a name="_toc137915596"></a><a name="_toc138675143"></a>**Table 12: Données du Capital décès dégressif (CDD)**

|**ID**|**Age**|**Année d'effet**|**Ann\_e\_d\_expiration**|**Dur\_e\_de\_contrat**|**Durre.contrat.restante**|**Prime**|**Capital\_d\_c\_s\_initial**|
| -: | -: | -: | -: | -: | -: | -: | -: |
|1400001|46|2017|2037|20|15|55 624|2 625 000|
|1400002|43|2017|2042|25|20|94 684|1 785 000|
|1400003|35|2014|2039|25|17|4 113|262 500|



#### <a name="tableau-damortissement"></a>**Tableau d’amortissement**
Le capital étant dégressif, il est primordial de voir comment se capital est amorti tout au long de la durée du contrat. Voici un exemple d’amortissement d’un contrat de durée *25 ans*, de date d’effet 2017, de capital initial *1 785 000* **MAD**. Le montant des annuités vaut *114 261* **MAD** sachant que le taux d’intérêt est de *4%***.**

<a name="tbl-amort-1"></a><a name="tbl-amort"></a><a name="_toc137673505"></a><a name="_toc137673654"></a><a name="_toc137718714"></a><a name="_toc137915597"></a><a name="_toc138675144"></a>**Table 13: Tableau d’amortissement
\*CRP désigne le capital restant à payer en cas de décès**

|Annee|CRP|Intérêts|Amortissement|Annuité|
| -: | -: | -: | -: | -: |
|2017|1785000|71400|42861|114261|
|2018|1742139|69686|44576|114261|
|2019|1697563|67903|46359|114261|
|2020|1651204|66048|48213|114261|
|2021|1602991|64120|50142|114261|
|2022|1552849|62114|52147|114261|
|2023|1500702|60028|54233|114261|
|2024|1446468|57859|56403|114261|
|2025|1390066|55603|58659|114261|
|2026|1331407|53256|61005|114261|
|2027|1270402|50816|63445|114261|
|2028|1206957|48278|65983|114261|
|2029|1140974|45639|68622|114261|
|2030|1072351|42894|71367|114261|
|2031|1000984|40039|74222|114261|
|2032|926762|37070|77191|114261|
|2033|849571|33983|80279|114261|
|2034|769293|30772|83490|114261|
|2035|685803|27432|86829|114261|
|2036|598974|23959|90302|114261|
|2037|508671|20347|93915|114261|
|2038|414757|16590|97671|114261|
|2039|317086|12683|101578|114261|
|2040|215508|8620|105641|114261|
|2041|109867|4395|109867|114261|
|2042|0|0|0|0|

Ce calcul se fait automatiquement par l’application à partir de la table de données.
#### <a name="projection-du-capital-ammorti"></a>**Projection du capital amorti**
Maintenant que nous disposant du capital amorti pour la durée du contrat, l’étape qui s’en suit est de déterminer la valeur probable de ce capital. On sait que ce capital sera versé qu’en cas de décès de l’assuré. Alors, pour une année *j* de projection de donnée, le capital restant (*VPC*) est versé que si l’assuré d’âge *x* survit jusqu’à l’année *j-1* et décède à l’année *j*. En terme mathématiques :

*VPCj=j-1px×qx+j\*CRPj*


#### <a name="résultats-et-interprétations"></a>**Résultats et interprétations**
L’onglet dédié à cette opération d’assurance de capital décès dégressif, après tout calcul, fournit les résultat suivants :


|<a name="tbl-bevie"></a>**Meilleure estimation des garanties probabilisées**|**Meilleure estimation des frais de gestions**|
| :- | :- |
|183 895 103|3 725 418|



|<p></p><p>**Aperçu des résultat dans l’application**</p>|
| :-: |
### <a name="_toc138675102"></a><a name="part-des-cessionnaires"></a>**Part des cessionnaires**
La part des cessionnaires est déterminées conformément aux spécification techniques de l’ACAPS. Les taux de cession sont fournis dans l’onglet paramètres et peuvent être modifiés en fonction du traité de réassurance correspondant à l’étude :

- **Taux de cession des engagements vie** : *1%*,
- **Taux de cession primes non-vie** : *5%*,
- **Taux de cession sinistres non-vie** : *3%*.

La meilleure estimations des engagements pour primes non-vie étant négative, on s’attend aussi à une cession négative des primes.

<a name="_toc137673569"></a><a name="_toc137718618"></a><a name="_toc137915583"></a><a name="_toc137978914"></a><a name="_toc138675130"></a>**Figure 22: Part des cessionnaires**

|<p></p><p></p>|
| :-: |
### <a name="fig-cession"></a><a name="_toc138675103"></a><a name="capital-de-solvabilité-requis"></a>**Capital de solvabilité requis**
En tenant compte des paramètres renseigné dans le premier onglet ainsi que de tous les calculs effectués dans les autres onglets, il en ressort les capitaux de solvabilité requis pour les risque de souscription vie et non vie indiqué à la figure suivante :

<a name="tbl-csr_vie_non"></a><a name="_toc137673506"></a><a name="_toc137673655"></a><a name="_toc137718715"></a><a name="_toc137915598"></a><a name="_toc138675145"></a>**Table 14: CSR Souscription**

|CSR Souscription vie|CSR Souscription non-vie|
| :- | :- |
|52 496 918|197 616|

<a name="tbl-csr_sousrisk"></a><a name="_toc137673507"></a><a name="_toc137673656"></a><a name="_toc137718716"></a><a name="_toc137915599"></a><a name="_toc138675146"></a>**Table 15: CSR Sous-risques**

|CSR mortalité|CSR catastrophe|CSR frais|
| :-: | :-: | :-: |
|52 485 959|353 884|1 012 563|



<a name="tbl-rm"></a><a name="_toc137673508"></a><a name="_toc137673657"></a><a name="_toc137718717"></a><a name="_toc137915600"></a><a name="_toc138675147"></a>**Table 16: Marges de risques**

|Marge de risque non-vie|Marge de risque vie|
| :- | :- |
|9 338 125|19 965 000|



<a name="_toc137673570"></a><a name="_toc137718619"></a><a name="_toc137915584"></a><a name="_toc137978915"></a><a name="_toc138675131"></a>**Figure 23: les CSR calculés**

|<p></p><p></p>|
| :-: |
<a name="fig-csr"></a>Nous avons supposé que les sous risques sont indépendants entendant la publication de la matrice de corrélation entre ces sous-risques.


# <a name="_toc138675104"></a>***Conclusion***
<a name="conclusion"></a>L’assurance est une opération de garantie de risque en contrepartie d’une prime. De ce fait, le secteur de l’assurance demeure très visqueux en termes de risques encourus. Il est de la responsabilité des autorités de réglementer ce milieu car la ruine d’une compagnie peut engendrer des conséquences néfastes à l’économie globale.

La Solvabilité Basée sur les Risques (SBR) est une réforme en cours d’élaboration qui est inspirée de la directive européenne *Solvabilité II*. Lors de ce stage au sein de **ARM CONSULTANTS**, nous avons développé une application avec le langage ***R*** permettant de calculer le capital de solvabilité requis (***SCR***) comme indiqué par la norme ***SBR***. L’élaboration de notre application a nécessité une étape préliminaire qui consistait à formaliser mathématiquement les directives de l’***ACAPS*** .L’application automatise tous le processus de calcul permettant ainsi une utilisation sans avoir, au préalable, connaissance du langage R. L’objectif est d’anticiper la disponibilité d’un outil de calcul des ***SCR*** afin de faciliter la transition vers la nouvelle norme. 

Notre application présente bon nombre d’avantages. Elle demande peu d’intervention de l’utilisateur lors de son usage. L’interface visuelle est très moderne, avec une structure bien ordonnée permettant une utilisation intuitive sans guide. En plus, puisque la construction des courbes des taux est prise en charge, notre application permet de détecter automatique la période de projection pour ensuite effectuer toute les actualisations requises.

Cependant, cet outil de calcul présente certaines limites. En effet, l’application demande quelques manipulations préalables afin d’obtenir certains inputs comme le taux de frais de gestion moyen et les taux de cessions.

Des améliorations futurs seraient d’afficher plus d’étapes dans les calculs. Par exemple on pourrait permettre à l’utilisateur d’afficher pour chaque contrat, le tableau d’amortissement. Il pourrait ensuite télécharger ce tableau pour une utilisation à d’autres fins. On peut aussi envisager des inputs entre les étapes. Ainsi, un utilisateur qui dispose d’un triangle de règlements complet, pourrait sauter l’étape de calcul du triangle inférieur étant donné qu’il dispose déjà de ces résultats. 

Ce stage nous a permis de renforcer nos connaissance en assurance. Au cours de notre passage dans ce cabinet, nous étions parfois appelés à travailler sur des missions du cabinet auprès d’actuaires qualifiés. Cela nous nous  a permis de se confronter à des problématiques réelles du marché. Cette expérience acquise, est aussi le fruit d’un encadrement étroit dont nous avons fait objet. Le Directeur du cabinet nous a donné l’opportunité d’apprendre non seulement de ce sujet de stage, mais aussi d’avoir connaissance du milieu professionnel et de ces exigences. Cette proximité avec des personnes aussi qualifiées a aiguisé nos ambitions et attisé nos intérêts à se spécialiser dans le secteur d’assurance.
**


**Références**

[1] Alonso Peña, Ph.D., Advanced Quantitative Finance with C++, June 2014

[2] Projet de circulaire « Solvabilité Basée sur les Risques (SBR) », version du 01/10/2020.

[3] Formation « Solvabilité Basée sur les Risques (SBR) : L’expérience Marocaine » Par Banque de France, [4] Luxembourg - Novembre 2018.

[5] Actuairis Consulting, Formation « Réforme SBR : une approche intégrée des risques », Séminaire régional CGA – IAIS, Tunis, le 12 mars 2019.

[6]  LOTFI Youness, MOUTAOUKIL Waily “IFRS 17 : Interprétation de la norme et étude d’impact pour le produit RC Auto ”, INSEA 2020.

[7] An Introduction to Recurrent Neural Networks and the Math That Powers Them.  

[8] Valentin NOËL, Séries temporelles et réseaux de neurones récurrents , Édité le 05/09/2022

[9]  Kawtar ZINE, Gloire Dorian MAVOUNGOU « Elaboration d’un outil informatique pour le calcul des provisions prudentielles et du capital de solvabilité requis selon les dispositifs du pilier I de la SBR, en assurance vie et non vie », INSEA 2022.


# <a name="_toc138675105"></a>***ANNEXE N°1 : <a name="annexe-n1-marge-de-risque"></a>Code source du modèle LSTM***
- **import pandas as pd**
  **import matplotlib.pyplot as plt**
  **import tensorflow as tf**
  **from tensorflow.keras.models import Sequential**
  **from tensorflow.keras.layers import Dense, LSTM, Dropout**
  **import numpy as np**

  **#Lecture du fichier csv**
  **df = pd.read\_csv('Moroccan All Shares - Données Historiques.csv')**

  **# Conversion en nombres**
  **def convert\_num(x):**
  `    `**x = x.replace(" ", "")**
  `    `**x = x.replace(".", "")**
  `    `**x = x.replace(",", ".")**
  `    `**return float(x)**

  **# Conversion des pourcentages en nombres**
  **def pct\_to\_num(x):**
  `    `**x = x.replace(" ", "")**
  `    `**x = x.replace(",", ".")**
  `    `**x = x.replace("%", "")**
  `    `**return float(x)**

  **# Appliquer les fonctions de conversion aux colonnes appropriées**
  **df\_temp = df.loc[:, ~df.columns.isin(["Date", "Variation %","Vol."])].applymap(convert\_num)**
  **df.loc[:, ~df.columns.isin(["Date", "Variation %","Vol."])] = df\_temp**
  **df["Variation %"] = df["Variation %"].apply(pct\_to\_num)**


  **# Préparer les données**
  **# Supposons que df est un dataframe contenant les données historiques**
  **# avec les colonnes suivantes: Date, Dernier, Ouv., Plus Haut, Plus Bas, Vol., Variation %**
  **# On va utiliser les 5 dernières observations comme entrées du modèle**
  **# et prédire le cours Dernier à la prochaine date**

  **# Convertir les données en numpy arrays**
  **X = df[['Dernier','Ouv.',' Plus Haut', 'Plus Bas']].to\_numpy()**
  **y = df["Dernier"].to\_numpy()**

  **# Normaliser les données**
  **from sklearn.preprocessing import MinMaxScaler**
  **scaler = MinMaxScaler()**
  **X = scaler.fit\_transform(X)**
  **y = scaler.fit\_transform(y.reshape(-1, 1))**

  **# Créer des séquences de données**
  **# Chaque séquence contient 5 observations consécutives (timesteps) comme entrée**
  **# et le cours Dernier à la prochaine observation comme sortie**
  **X\_seq = []**
  **y\_seq = []**
  **timesteps = 5**
  **for i in range(timesteps, len(X)):**
  `  `**X\_seq.append(X[i-timesteps:i])**
  `  `**y\_seq.append(y[i])**
  **X\_seq = np.array(X\_seq)**
  **y\_seq = np.array(y\_seq)**

  **# Diviser les données en train et test sets**
  **train\_size = int(len(X\_seq) \* 0.95)**
  **X\_train, X\_test = X\_seq[:train\_size], X\_seq[train\_size:]**
  **y\_train, y\_test = y\_seq[:train\_size], y\_seq[train\_size:]**

  **# Définir le modèle RNN**
  **model = Sequential()**
  **model.add(LSTM(units=50, return\_sequences=True,** 
  `               `**input\_shape=(X\_train.shape[1], X\_train.shape[2])))**
  **model.add(Dropout(0.2))**
  **model.add(LSTM(units=50, return\_sequences=True))**
  **model.add(Dropout(0.2))**
  **model.add(LSTM(units=50))**
  **model.add(Dropout(0.2))**
  **model.add(Dense(units=1))**

  **# Compiler le modèle**
  **model.compile(optimizer='adam', loss='mean\_squared\_error')**

  **# Entraîner le modèle**
  **model.fit(X\_train, y\_train, epochs=100, batch\_size=30)**

  **# Faire des prédictions**
  **y\_pred = model.predict(X\_test)**
  **y\_pred = scaler.inverse\_transform(y\_pred) # Revenir à l'échelle originale**

  **# Évaluer le modèle**
  **from sklearn.metrics import mean\_squared\_error**
  **rmse = np.sqrt(mean\_squared\_error(scaler.inverse\_transform(y\_test), y\_pred))**
  **print('RMSE: ', rmse)**

  **# Tracer les valeurs observées et prédites**

  **plt.plot(scaler.inverse\_transform(y\_test), label='Dernier cours observé')**
  **plt.plot(y\_pred, label='Dernier cours prédite')**
  **plt.legend()**
  **plt.xlabel('Jours')**
  **plt.ylabel('Dernier cours')**
  **plt.title('Prédiction du dernier cours avec un modèle LSTM')**
  **plt.show()**

# <a name="_toc138675106"></a>***ANNEXE N°2 : CORRESPONDANCE ENTRE ECHELLE DE NOTATION ET PROBABILITE DE DEFAUT***
## <a name="_toc138675107"></a>**Échelles de notation**
- <a name="echelles-de-notation"></a>Pour les cessionnaires et les cédantes :

L’échelle de notation à retenir correspond à la notation financière la plus récente délivrée, durant les dix-huit (18) derniers mois, par l’une des agences de notation citées ci-dessous et ce, conformément au tableau de correspondance suivant :

|**Échelle de notation**|**S&P**|**FITCH RATING**|**AM BEST**|
| :- | :- | :- | :- |
|1|Supérieure ou égale à AA|Supérieure ou égale à AA|Supérieure ou égale à AA|
|2|Inférieure à AA et supérieure ou égale à A|Inférieure à AA et supérieure ou égale à A|Inférieure à AA et supérieure ou égale à A|
|3|Inférieure A et supérieure ou égale à BBB|Inférieure A et supérieure ou égale à BBB|Inférieure à A et supérieure ou égale à BBB|
|4|Inférieure à BBB et supérieure ou égale à BB|Inférieure à BBB et supérieure ou égale à BB|Inférieure à BBB et supérieure ou égale à BB|
|5|Inférieure à BB|Inférieure à BB|Inférieure à BB|

En l’absence de notation financière délivrée, durant les dix-huit (18) derniers mois, par l’une des agences de notation financière précitées et en l’absence d’une notation financière équivalente justifiée, durant la même période, l’échelle de notation est retenue en fonction du ratio de solvabilité du cessionnaire ou de la cédante concerné et ce, conformément au tableau de correspondance suivant :

|Échelle de notation|Ratio de solvabilité|
| :- | :- |
|1|Supérieur à 175%|
|2|]122% ; 175%]|
|3|]95% ; 122%]|
|4|]75% ; 95%]|
|5|Inférieur ou égale à 75%|

Dans les autres cas, l’échelle de notation la plus faible est retenue.

- Pour les organismes dépositaires :

L’échelle de notation à retenir correspond à la notation financière la plus récente délivrée, durant les dix-huit (18) derniers mois, par l’une des agences de notation citées ci-dessous et ce, conformément au tableau de correspondance suivant :

<a name="_toc137718718"></a><a name="_toc137915601"></a><a name="_toc138675148"></a>***Table 17: Échelle de notation***

|**Échelle de notation**|**S&P**|**FITCH RATINGS**|**MOODY'S**|
| :- | :- | :- | :- |
|1|Supérieure ou égale à AA|Supérieure ou égale à AA|Supérieure ou égale à Aa|
|2|Inférieure à AA et supérieure ou égale à A|Inférieure à AA et supérieure ou égale à A|Inférieure à Aa et supérieure ou égale à A|
|3|Inférieure A et supérieure ou égale à BBB|Inférieure A et supérieure ou égale à BBB|Inférieure A et supérieure ou égale à Baa|
|4|Inférieure à BBB et supérieure ou égale à BB|Inférieure à BBB et supérieure ou égale à BB|Inférieure à Baa et supérieure ou égale à Ba|
|5|Inférieure à BB|Inférieure à BB|Inférieure à Ba|

En l’absence de notation financière délivrée, durant les dix-huit (18) derniers mois, par l’une des agences de notation financière précitées et en l’absence d’une notation financière équivalente justifiée, durant la même période, l’échelle de notation est retenue en fonction du ratio de solvabilité de l’organisme dépositaire concerné et ce, conformément au tableau de correspondance suivant :

<a name="_toc137718719"></a><a name="_toc137915602"></a><a name="_toc138675149"></a>***Table 18: Correspondance entre échelle de notation et ratio de solvabilité***

|**Échelle de notation**|**Ratio de solvabilité**|
| :- | :- |
|1|Supérieur à 21%|
|2|]14,6% ; 21%]|
|3|]11,4% ; 14,6%]|
|4|]9% ; 11,4%]|
|5|Inférieur ou égale à 9%|

Dans les autres cas, l’échelle de notation la plus faible est retenue.
## <a name="_toc138675108"></a>**Probabilités de défaut :**
<a name="x19201d892d1ecf03d622680eb90ba507529139d"></a><a name="probabilités-de-défaut"></a>La probabilité de défaut annuelle est établie en fonction de l’échelle de notation retenue en application des dispositions du 1) ci-dessus et ce, conformément au tableau de correspondance ci-après :

<a name="_toc137718720"></a><a name="_toc137915603"></a><a name="_toc138675150"></a>***Table 19: Correspondance entre Échelle de notation et Probabilité de défaut annuelle***

|**Échelle de notation**|**Probabilité de défaut annuelle**|
| :- | :- |
|1|0,010%|
|2|0,050%|
|3|0,240%|
|4|1,200%|
|5|4,200%|


[^1]: ` `*https://www.acaps.ma/fr/l-acaps/missions*
[^2]: ` `*https://www.atlas-mag.net/article/marche-africain-de-l-assurance-en-2019-chiffre-d-affaires-des-principaux-pays*
[^3]: ` `*solvabilité basée sur les risques assurances Maroc , ACAPS*
[^4]: ` `*https://fnh.ma/article/actualite-financiere-maroc/assurances-solvabilite-basee-sur-les-risques-les-seuils-minimums-fixes-en-janvier-2019*
[^5]: ` `*ORSA : Own Risk and Solvency Assessment*
[^6]: ` `*[**Circulaire en préparation concernant le second pilier relatif à la gouvernance**](https://fnh.ma/article/actualite-financiere-maroc/assurances-sbr-un-projet-de-circulaire-en-preparation)*
[^7]: ` `*La métrique de risque n’est pas encore définie dans le projet marocain SBR*
[^8]: ` `*Alonso Peña, Ph.D, C++ For Quantitative Finance*
[^9]: ` `*The Actuary and IBNR publié en 1972*
[^10]: ` `*CNAM 2002-2003, Mathématiques actuarielles fondamentales (assurance non vie), Éléments de cours – 24 mars 2003 – liquidation des sinistres*