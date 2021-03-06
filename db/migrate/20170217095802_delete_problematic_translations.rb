require_relative "helpers/delete_content"

class DeleteProblematicTranslations < ActiveRecord::Migration[5.0]
  def up

    #Wrong routes
    base_paths_200_302 = %w(
      /government/publications/uk-house-price-index-summary-october-2016/1847977
      /government/publications/uk-house-price-index-wales-august-2016/1747267
      /government/publications/uk-house-price-index-wales-october-2016/1849478
      /government/publications/uk-house-price-index-wales-september-2016/1800142
      /government/publications/application-for-mot-managers-course-vt79/guidance-on-applying-for-the-mot-manager-training-course
      /government/publications/doing-business-in-luxembourg/exporting-to-luxembourg
      /government/publications/let-property-campaign-notification-form/guidance-for-filling-in-this-form
      /government/publications/national-curriculum-assessments-future-test-dates/future-assessment-arrangements
      /government/publications/nominated-tester-training-ntt-assessment-questions/mot-nominated-tester-training-ntt-assessment-questions
      /government/publications/nominated-tester-training/guidance-on-applying-for-mot-nominated-tester-training-ntt-for-new-and-returning-testers
      /government/publications/post-initial-teacher-training-subject-knowledge-enhancement-teaching-school-alliances/post-initial-teacher-training-subject-knowledge-enhancement-teaching-school-alliances
    )

    #Bad world location news article
    base_paths_bad_wlna = %w(
      /government/world-location-news/176020.ar
      /government/world-location-news/181967.ar
      /government/world-location-news/186635.ar
      /government/world-location-news/188107.ar
      /government/world-location-news/188497.ar
      /government/world-location-news/192269.ar
      /government/world-location-news/197760.ar
      /government/world-location-news/208365.ar
      /government/world-location-news/209973.ar
      /government/world-location-news/210451.ar
      /government/world-location-news/213279.ar
      /government/world-location-news/220227.ar
      /government/world-location-news/252842.ar
      /government/world-location-news/257525.ar
      /government/world-location-news/288939.ar
      /government/world-location-news/295713.ar
      /government/world-location-news/297272.ar
      /government/world-location-news/233481.az
      /government/world-location-news/211747.bg
      /government/world-location-news/259309.bg
      /government/world-location-news/297307.bg
      /government/world-location-news/179127.cs
      /government/world-location-news/179566.cs
      /government/world-location-news/186101.cs
      /government/world-location-news/186484.cs
      /government/world-location-news/188291.cs
      /government/world-location-news/201804.cs
      /government/world-location-news/222872.cs
      /government/world-location-news/239306.cs
      /government/world-location-news/241353.cs
      /government/world-location-news/260600.cs
      /government/world-location-news/260995.cs
      /government/world-location-news/266786.cs
      /government/world-location-news/289124.cs
      /government/world-location-news/289728.cs
      /government/world-location-news/297168.cs
      /government/world-location-news/297697.cs
      /government/world-location-news/171411.de
      /government/world-location-news/171610.de
      /government/world-location-news/171976.de
      /government/world-location-news/200903.de
      /government/world-location-news/201788.de
      /government/world-location-news/209605.de
      /government/world-location-news/215070.de
      /government/world-location-news/215515.de
      /government/world-location-news/241312.de
      /government/world-location-news/245735.de
      /government/world-location-news/261513.de
      /government/world-location-news/263764.de
      /government/world-location-news/278993.de
      /government/world-location-news/292905.de
      /government/world-location-news/294250.de
      /government/world-location-news/294647.de
      /government/world-location-news/171317.el
      /government/world-location-news/200905.el
      /government/world-location-news/208332.el
      /government/world-location-news/239922.el
      /government/world-location-news/242212.el
      /government/world-location-news/257123.el
      /government/world-location-news/258126.el
      /government/world-location-news/260295.el
      /government/world-location-news/261564.el
      /government/world-location-news/277800.el
      /government/world-location-news/282154.el
      /government/world-location-news/292182.el
      /government/world-location-news/296412.el
      /government/world-location-news/171142.es-419
      /government/world-location-news/171845.es-419
      /government/world-location-news/171850.es-419
      /government/world-location-news/172237.es-419
      /government/world-location-news/173801.es-419
      /government/world-location-news/174342.es-419
      /government/world-location-news/174628.es-419
      /government/world-location-news/174914.es-419
      /government/world-location-news/174916.es-419
      /government/world-location-news/175313.es-419
      /government/world-location-news/175426.es-419
      /government/world-location-news/175433.es-419
      /government/world-location-news/175727.es-419
      /government/world-location-news/175818.es-419
      /government/world-location-news/176254.es-419
      /government/world-location-news/176496.es-419
      /government/world-location-news/179098.es-419
      /government/world-location-news/179512.es-419
      /government/world-location-news/179513.es-419
      /government/world-location-news/183869.es-419
      /government/world-location-news/186178.es-419
      /government/world-location-news/192401.es-419
      /government/world-location-news/192620.es-419
      /government/world-location-news/192707.es-419
      /government/world-location-news/192952.es-419
      /government/world-location-news/197735.es-419
      /government/world-location-news/197833.es-419
      /government/world-location-news/200705.es-419
      /government/world-location-news/201656.es-419
      /government/world-location-news/202481.es-419
      /government/world-location-news/206678.es-419
      /government/world-location-news/206840.es-419
      /government/world-location-news/208137.es-419
      /government/world-location-news/210374.es-419
      /government/world-location-news/211753.es-419
      /government/world-location-news/212008.es-419
      /government/world-location-news/212013.es-419
      /government/world-location-news/212016.es-419
      /government/world-location-news/212120.es-419
      /government/world-location-news/213493.es-419
      /government/world-location-news/213614.es-419
      /government/world-location-news/215108.es-419
      /government/world-location-news/215578.es-419
      /government/world-location-news/216867.es-419
      /government/world-location-news/217637.es-419
      /government/world-location-news/218024.es-419
      /government/world-location-news/220494.es-419
      /government/world-location-news/220691.es-419
      /government/world-location-news/221791.es-419
      /government/world-location-news/224623.es-419
      /government/world-location-news/224830.es-419
      /government/world-location-news/224845.es-419
      /government/world-location-news/225271.es-419
      /government/world-location-news/225719.es-419
      /government/world-location-news/226151.es-419
      /government/world-location-news/226541.es-419
      /government/world-location-news/228905.es-419
      /government/world-location-news/230453.es-419
      /government/world-location-news/230454.es-419
      /government/world-location-news/231664.es-419
      /government/world-location-news/231924.es-419
      /government/world-location-news/232191.es-419
      /government/world-location-news/232335.es-419
      /government/world-location-news/233487.es-419
      /government/world-location-news/235129.es-419
      /government/world-location-news/235130.es-419
      /government/world-location-news/235132.es-419
      /government/world-location-news/238462.es-419
      /government/world-location-news/239810.es-419
      /government/world-location-news/239826.es-419
      /government/world-location-news/240427.es-419
      /government/world-location-news/240607.es-419
      /government/world-location-news/240897.es-419
      /government/world-location-news/241850.es-419
      /government/world-location-news/241853.es-419
      /government/world-location-news/242763.es-419
      /government/world-location-news/243962.es-419
      /government/world-location-news/246679.es-419
      /government/world-location-news/246875.es-419
      /government/world-location-news/247572.es-419
      /government/world-location-news/252071.es-419
      /government/world-location-news/252564.es-419
      /government/world-location-news/253263.es-419
      /government/world-location-news/253410.es-419
      /government/world-location-news/253913.es-419
      /government/world-location-news/254304.es-419
      /government/world-location-news/254431.es-419
      /government/world-location-news/255470.es-419
      /government/world-location-news/255674.es-419
      /government/world-location-news/257368.es-419
      /government/world-location-news/260920.es-419
      /government/world-location-news/260940.es-419
      /government/world-location-news/261754.es-419
      /government/world-location-news/261897.es-419
      /government/world-location-news/261960.es-419
      /government/world-location-news/262799.es-419
      /government/world-location-news/262824.es-419
      /government/world-location-news/263027.es-419
      /government/world-location-news/263031.es-419
      /government/world-location-news/263173.es-419
      /government/world-location-news/263748.es-419
      /government/world-location-news/263836.es-419
      /government/world-location-news/264569.es-419
      /government/world-location-news/265638.es-419
      /government/world-location-news/267540.es-419
      /government/world-location-news/267782.es-419
      /government/world-location-news/268305.es-419
      /government/world-location-news/268452.es-419
      /government/world-location-news/269052.es-419
      /government/world-location-news/269080.es-419
      /government/world-location-news/269087.es-419
      /government/world-location-news/270327.es-419
      /government/world-location-news/270701.es-419
      /government/world-location-news/271936.es-419
      /government/world-location-news/271974.es-419
      /government/world-location-news/271975.es-419
      /government/world-location-news/271976.es-419
      /government/world-location-news/271980.es-419
      /government/world-location-news/272153.es-419
      /government/world-location-news/272653.es-419
      /government/world-location-news/272820.es-419
      /government/world-location-news/273314.es-419
      /government/world-location-news/273582.es-419
      /government/world-location-news/273585.es-419
      /government/world-location-news/276545.es-419
      /government/world-location-news/278419.es-419
      /government/world-location-news/278578.es-419
      /government/world-location-news/280299.es-419
      /government/world-location-news/281728.es-419
      /government/world-location-news/283262.es-419
      /government/world-location-news/283719.es-419
      /government/world-location-news/283726.es-419
      /government/world-location-news/284564.es-419
      /government/world-location-news/284721.es-419
      /government/world-location-news/284868.es-419
      /government/world-location-news/285667.es-419
      /government/world-location-news/286041.es-419
      /government/world-location-news/287786.es-419
      /government/world-location-news/287819.es-419
      /government/world-location-news/289214.es-419
      /government/world-location-news/289218.es-419
      /government/world-location-news/289534.es-419
      /government/world-location-news/291000.es-419
      /government/world-location-news/291410.es-419
      /government/world-location-news/291490.es-419
      /government/world-location-news/291812.es-419
      /government/world-location-news/291857.es-419
      /government/world-location-news/292063.es-419
      /government/world-location-news/292871.es-419
      /government/world-location-news/293194.es-419
      /government/world-location-news/293828.es-419
      /government/world-location-news/294043.es-419
      /government/world-location-news/294159.es-419
      /government/world-location-news/294171.es-419
      /government/world-location-news/295391.es-419
      /government/world-location-news/295550.es-419
      /government/world-location-news/296261.es-419
      /government/world-location-news/296578.es-419
      /government/world-location-news/172155.es
      /government/world-location-news/172440.es
      /government/world-location-news/173707.es
      /government/world-location-news/175082.es
      /government/world-location-news/175092.es
      /government/world-location-news/175208.es
      /government/world-location-news/175233.es
      /government/world-location-news/176196.es
      /government/world-location-news/179097.es
      /government/world-location-news/182363.es
      /government/world-location-news/192094.es
      /government/world-location-news/192303.es
      /government/world-location-news/197196.es
      /government/world-location-news/197264.es
      /government/world-location-news/197500.es
      /government/world-location-news/197692.es
      /government/world-location-news/201393.es
      /government/world-location-news/203079.es
      /government/world-location-news/203151.es
      /government/world-location-news/203338.es
      /government/world-location-news/206719.es
      /government/world-location-news/208807.es
      /government/world-location-news/210535.es
      /government/world-location-news/211933.es
      /government/world-location-news/212818.es
      /government/world-location-news/212994.es
      /government/world-location-news/215309.es
      /government/world-location-news/215466.es
      /government/world-location-news/215484.es
      /government/world-location-news/215616.es
      /government/world-location-news/215667.es
      /government/world-location-news/217375.es
      /government/world-location-news/217876.es
      /government/world-location-news/222582.es
      /government/world-location-news/222658.es
      /government/world-location-news/225635.es
      /government/world-location-news/225644.es
      /government/world-location-news/226266.es
      /government/world-location-news/228522.es
      /government/world-location-news/229240.es
      /government/world-location-news/229283.es
      /government/world-location-news/229984.es
      /government/world-location-news/231029.es
      /government/world-location-news/232340.es
      /government/world-location-news/233503.es
      /government/world-location-news/235255.es
      /government/world-location-news/235482.es
      /government/world-location-news/237972.es
      /government/world-location-news/238159.es
      /government/world-location-news/241585.es
      /government/world-location-news/242775.es
      /government/world-location-news/247706.es
      /government/world-location-news/253328.es
      /government/world-location-news/255719.es
      /government/world-location-news/255741.es
      /government/world-location-news/256627.es
      /government/world-location-news/259846.es
      /government/world-location-news/260245.es
      /government/world-location-news/261976.es
      /government/world-location-news/262765.es
      /government/world-location-news/264303.es
      /government/world-location-news/274156.es
      /government/world-location-news/275931.es
      /government/world-location-news/276130.es
      /government/world-location-news/279743.es
      /government/world-location-news/279923.es
      /government/world-location-news/282770.es
      /government/world-location-news/283332.es
      /government/world-location-news/286183.es
      /government/world-location-news/286266.es
      /government/world-location-news/287200.es
      /government/world-location-news/289040.es
      /government/world-location-news/289081.es
      /government/world-location-news/291100.es
      /government/world-location-news/292953.es
      /government/world-location-news/293476.es
      /government/world-location-news/296094.es
      /government/world-location-news/173989.fa
      /government/world-location-news/171417.fr
      /government/world-location-news/171493.fr
      /government/world-location-news/172185.fr
      /government/world-location-news/172683.fr
      /government/world-location-news/173928.fr
      /government/world-location-news/200799.fr
      /government/world-location-news/201650.fr
      /government/world-location-news/201813.fr
      /government/world-location-news/203257.fr
      /government/world-location-news/208245.fr
      /government/world-location-news/210097.fr
      /government/world-location-news/215726.fr
      /government/world-location-news/224941.fr
      /government/world-location-news/225724.fr
      /government/world-location-news/235976.fr
      /government/world-location-news/238145.fr
      /government/world-location-news/251432.fr
      /government/world-location-news/252816.fr
      /government/world-location-news/260250.fr
      /government/world-location-news/274901.fr
      /government/world-location-news/278088.fr
      /government/world-location-news/289369.fr
      /government/world-location-news/188643.he
      /government/world-location-news/192253.he
      /government/world-location-news/171320.it
      /government/world-location-news/171848.it
      /government/world-location-news/172625.it
      /government/world-location-news/176480.it
      /government/world-location-news/186354.it
      /government/world-location-news/186407.it
      /government/world-location-news/191838.it
      /government/world-location-news/191926.it
      /government/world-location-news/193191.it
      /government/world-location-news/201030.it
      /government/world-location-news/201405.it
      /government/world-location-news/209249.it
      /government/world-location-news/209598.it
      /government/world-location-news/215682.it
      /government/world-location-news/247944.it
      /government/world-location-news/263762.it
      /government/world-location-news/172535.ja
      /government/world-location-news/190265.ja
      /government/world-location-news/200721.ja
      /government/world-location-news/202126.ja
      /government/world-location-news/212474.ja
      /government/world-location-news/215446.ja
      /government/world-location-news/221237.ja
      /government/world-location-news/226260.ja
      /government/world-location-news/226877.ja
      /government/world-location-news/230636.ja
      /government/world-location-news/232492.ja
      /government/world-location-news/240657.ja
      /government/world-location-news/241859.ja
      /government/world-location-news/247580.ja
      /government/world-location-news/257425.ja
      /government/world-location-news/259782.ja
      /government/world-location-news/261172.ja
      /government/world-location-news/261585.ja
      /government/world-location-news/263032.ja
      /government/world-location-news/264620.ja
      /government/world-location-news/265215.ja
      /government/world-location-news/265655.ja
      /government/world-location-news/265657.ja
      /government/world-location-news/266025.ja
      /government/world-location-news/271981.ja
      /government/world-location-news/286425.ja
      /government/world-location-news/290702.ja
      /government/world-location-news/293342.ja
      /government/world-location-news/295021.ja
      /government/world-location-news/215586.ko
      /government/world-location-news/220387.ko
      /government/world-location-news/225521.ko
      /government/world-location-news/248692.ko
      /government/world-location-news/173029.lt
      /government/world-location-news/173244.lt
      /government/world-location-news/175196.lt
      /government/world-location-news/175441.lt
      /government/world-location-news/175737.lt
      /government/world-location-news/179024.lt
      /government/world-location-news/188215.lt
      /government/world-location-news/188385.lt
      /government/world-location-news/188434.lt
      /government/world-location-news/197866.lt
      /government/world-location-news/197991.lt
      /government/world-location-news/208464.lt
      /government/world-location-news/210578.lt
      /government/world-location-news/213055.lt
      /government/world-location-news/220268.lt
      /government/world-location-news/228781.lt
      /government/world-location-news/238189.lt
      /government/world-location-news/238329.lt
      /government/world-location-news/238420.lt
      /government/world-location-news/238435.lt
      /government/world-location-news/239845.lt
      /government/world-location-news/242214.lt
      /government/world-location-news/246593.lt
      /government/world-location-news/247699.lt
      /government/world-location-news/255564.lt
      /government/world-location-news/277472.lt
      /government/world-location-news/277486.lt
      /government/world-location-news/277968.lt
      /government/world-location-news/282701.lt
      /government/world-location-news/171176.pl
      /government/world-location-news/197155.pl
      /government/world-location-news/171667.pt
      /government/world-location-news/172849.pt
      /government/world-location-news/172968.pt
      /government/world-location-news/173577.pt
      /government/world-location-news/174063.pt
      /government/world-location-news/175432.pt
      /government/world-location-news/176080.pt
      /government/world-location-news/179003.pt
      /government/world-location-news/179074.pt
      /government/world-location-news/179099.pt
      /government/world-location-news/179150.pt
      /government/world-location-news/180582.pt
      /government/world-location-news/186091.pt
      /government/world-location-news/188230.pt
      /government/world-location-news/188483.pt
      /government/world-location-news/192069.pt
      /government/world-location-news/192676.pt
      /government/world-location-news/192706.pt
      /government/world-location-news/192763.pt
      /government/world-location-news/197638.pt
      /government/world-location-news/201192.pt
      /government/world-location-news/201421.pt
      /government/world-location-news/201932.pt
      /government/world-location-news/207012.pt
      /government/world-location-news/207014.pt
      /government/world-location-news/207015.pt
      /government/world-location-news/207016.pt
      /government/world-location-news/209252.pt
      /government/world-location-news/209261.pt
      /government/world-location-news/211480.pt
      /government/world-location-news/212142.pt
      /government/world-location-news/214930.pt
      /government/world-location-news/215246.pt
      /government/world-location-news/216480.pt
      /government/world-location-news/216573.pt
      /government/world-location-news/220338.pt
      /government/world-location-news/220532.pt
      /government/world-location-news/220711.pt
      /government/world-location-news/221033.pt
      /government/world-location-news/221408.pt
      /government/world-location-news/221591.pt
      /government/world-location-news/222285.pt
      /government/world-location-news/222697.pt
      /government/world-location-news/223229.pt
      /government/world-location-news/224837.pt
      /government/world-location-news/224841.pt
      /government/world-location-news/225603.pt
      /government/world-location-news/226243.pt
      /government/world-location-news/226373.pt
      /government/world-location-news/228934.pt
      /government/world-location-news/228956.pt
      /government/world-location-news/229714.pt
      /government/world-location-news/230033.pt
      /government/world-location-news/230354.pt
      /government/world-location-news/232577.pt
      /government/world-location-news/233437.pt
      /government/world-location-news/233491.pt
      /government/world-location-news/234925.pt
      /government/world-location-news/235531.pt
      /government/world-location-news/235744.pt
      /government/world-location-news/235864.pt
      /government/world-location-news/236157.pt
      /government/world-location-news/237791.pt
      /government/world-location-news/237892.pt
      /government/world-location-news/238160.pt
      /government/world-location-news/238161.pt
      /government/world-location-news/238911.pt
      /government/world-location-news/238912.pt
      /government/world-location-news/238913.pt
      /government/world-location-news/238916.pt
      /government/world-location-news/238921.pt
      /government/world-location-news/239068.pt
      /government/world-location-news/240207.pt
      /government/world-location-news/240208.pt
      /government/world-location-news/240209.pt
      /government/world-location-news/240210.pt
      /government/world-location-news/240429.pt
      /government/world-location-news/241398.pt
      /government/world-location-news/242260.pt
      /government/world-location-news/242623.pt
      /government/world-location-news/242722.pt
      /government/world-location-news/242996.pt
      /government/world-location-news/243006.pt
      /government/world-location-news/244351.pt
      /government/world-location-news/246128.pt
      /government/world-location-news/249069.pt
      /government/world-location-news/251691.pt
      /government/world-location-news/252203.pt
      /government/world-location-news/253081.pt
      /government/world-location-news/253083.pt
      /government/world-location-news/253325.pt
      /government/world-location-news/253585.pt
      /government/world-location-news/254396.pt
      /government/world-location-news/254970.pt
      /government/world-location-news/255672.pt
      /government/world-location-news/256826.pt
      /government/world-location-news/257296.pt
      /government/world-location-news/257415.pt
      /government/world-location-news/259213.pt
      /government/world-location-news/259217.pt
      /government/world-location-news/260204.pt
      /government/world-location-news/260560.pt
      /government/world-location-news/260563.pt
      /government/world-location-news/261385.pt
      /government/world-location-news/261575.pt
      /government/world-location-news/261720.pt
      /government/world-location-news/261846.pt
      /government/world-location-news/262678.pt
      /government/world-location-news/262681.pt
      /government/world-location-news/263029.pt
      /government/world-location-news/263630.pt
      /government/world-location-news/264315.pt
      /government/world-location-news/265419.pt
      /government/world-location-news/265644.pt
      /government/world-location-news/266820.pt
      /government/world-location-news/266908.pt
      /government/world-location-news/269252.pt
      /government/world-location-news/270679.pt
      /government/world-location-news/271027.pt
      /government/world-location-news/271245.pt
      /government/world-location-news/272182.pt
      /government/world-location-news/275112.pt
      /government/world-location-news/275213.pt
      /government/world-location-news/276977.pt
      /government/world-location-news/282318.pt
      /government/world-location-news/282671.pt
      /government/world-location-news/284117.pt
      /government/world-location-news/284716.pt
      /government/world-location-news/285657.pt
      /government/world-location-news/285666.pt
      /government/world-location-news/286083.pt
      /government/world-location-news/286234.pt
      /government/world-location-news/287987.pt
      /government/world-location-news/288732.pt
      /government/world-location-news/288819.pt
      /government/world-location-news/288940.pt
      /government/world-location-news/289211.pt
      /government/world-location-news/290534.pt
      /government/world-location-news/290860.pt
      /government/world-location-news/291176.pt
      /government/world-location-news/294453.pt
      /government/world-location-news/294579.pt
      /government/world-location-news/294701.pt
      /government/world-location-news/295678.pt
      /government/world-location-news/295683.pt
      /government/world-location-news/296916.pt
      /government/world-location-news/296924.pt
      /government/world-location-news/272888.ro
      /government/world-location-news/289930.ro
      /government/world-location-news/173355.ru
      /government/world-location-news/188638.ru
      /government/world-location-news/197273.ru
      /government/world-location-news/202702.ru
      /government/world-location-news/209290.ru
      /government/world-location-news/212549.ru
      /government/world-location-news/216904.ru
      /government/world-location-news/217493.ru
      /government/world-location-news/228158.ru
      /government/world-location-news/281177.ru
      /government/world-location-news/225393.sr
      /government/world-location-news/230569.sr
      /government/world-location-news/238444.sr
      /government/world-location-news/212806.th
      /government/world-location-news/173338.uk
      /government/world-location-news/262717.uk
      /government/world-location-news/274977.uk
      /government/world-location-news/172981.ur
      /government/world-location-news/176281.ur
      /government/world-location-news/193179.ur
      /government/world-location-news/213080.ur
      /government/world-location-news/175060.zh-tw
      /government/world-location-news/175840.zh-tw
      /government/world-location-news/178953.zh-tw
      /government/world-location-news/179503.zh-tw
      /government/world-location-news/186212.zh-tw
      /government/world-location-news/188502.zh-tw
      /government/world-location-news/189734.zh-tw
      /government/world-location-news/189739.zh-tw
      /government/world-location-news/192841.zh-tw
      /government/world-location-news/197379.zh-tw
      /government/world-location-news/197856.zh-tw
      /government/world-location-news/197857.zh-tw
      /government/world-location-news/203276.zh-tw
      /government/world-location-news/209141.zh-tw
      /government/world-location-news/210389.zh-tw
      /government/world-location-news/210510.zh-tw
      /government/world-location-news/210520.zh-tw
      /government/world-location-news/210686.zh-tw
      /government/world-location-news/213347.zh-tw
      /government/world-location-news/215732.zh-tw
      /government/world-location-news/216080.zh-tw
      /government/world-location-news/220114.zh-tw
      /government/world-location-news/220750.zh-tw
      /government/world-location-news/221235.zh-tw
      /government/world-location-news/221645.zh-tw
      /government/world-location-news/222109.zh-tw
      /government/world-location-news/228361.zh-tw
      /government/world-location-news/229395.zh-tw
      /government/world-location-news/231480.zh-tw
      /government/world-location-news/232909.zh-tw
      /government/world-location-news/238023.zh-tw
      /government/world-location-news/240063.zh-tw
      /government/world-location-news/245635.zh-tw
      /government/world-location-news/249089.zh-tw
      /government/world-location-news/250984.zh-tw
      /government/world-location-news/251447.zh-tw
      /government/world-location-news/252606.zh-tw
      /government/world-location-news/252778.zh-tw
      /government/world-location-news/254154.zh-tw
      /government/world-location-news/256970.zh-tw
      /government/world-location-news/260960.zh-tw
      /government/world-location-news/262114.zh-tw
      /government/world-location-news/263388.zh-tw
      /government/world-location-news/264597.zh-tw
      /government/world-location-news/268479.zh-tw
      /government/world-location-news/268483.zh-tw
      /government/world-location-news/276559.zh-tw
      /government/world-location-news/277623.zh-tw
      /government/world-location-news/282153.zh-tw
      /government/world-location-news/283286.zh-tw
      /government/world-location-news/289225.zh-tw
      /government/world-location-news/290168.zh-tw
      /government/world-location-news/292788.zh-tw
      /government/world-location-news/294626.zh-tw
      /government/world-location-news/296968.zh-tw
      /government/world-location-news/247263.zh
      /government/world-location-news/272824.zh
      /government/world-location-news/274722.zh
      /government/world-location-news/282389.zh
      /government/world-location-news/282404.zh
      /government/world-location-news/286926.zh
      /government/world-location-news/291036.zh
    )

    base_paths = base_paths_200_302 + base_paths_bad_wlna

    ids = Edition.where(base_path: base_paths, publishing_app: "whitehall").joins(:document).distinct.pluck(:content_id)
    Helpers::DeleteContent.destroy_documents_with_links(ids)
  end
end
