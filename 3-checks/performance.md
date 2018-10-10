---
title: Performance
layout: page
---

Performance can be measured in a variety of ways. For Nuspell, performance is firstly measured in terms of correctness of spell checking functionality and speedup compared to Hunspell.

# Verification Nuspell vs. Hunspell

Below are the overall results from the [verification testing](https://en.wikipedia.org/wiki/Software_verification) in terms if functional and speedup performance for the latest version of Nuspell, i.e. commit [`d19aab5`](https://github.com/nuspell/nuspell/commit/d19aab5ea8a492c6f526dc7a04869b6bcf231c05) from 2018-10-09 at 20:36:19.  This is done by using [words lists](https://github.com/nuspell/nuspell/wiki/Word-List-Files) and [dictionaries](https://github.com/nuspell/nuspell/wiki/Dictionary-Files) for 86 different languages.

| metric statistics | minimum | mean - std. (capped) | mean | mean + std. (capped) | maximum |
|---|--:|--:|--:|--:|--:|
| **accuracy** | `0.902` | `0.982` | `0.997` | `1.000` | `1.000` |
| **precision** | `0.996` | `0.999` | `1.000` | `1.000` | `1.000` |
| **speedup** | `0.44` | `0.89` | `1.26` | `1.63` | `2.15` |
| <small>words tested</small> | <small>`18`</small> | <small>`18`</small> | <small>`272,217`</small> | <small>`744,617`</small> | <small>`3,802,878`</small> |
| <small>true positive rate</small> | <small>`0.411`</small> | <small>`0.864`</small> | <small>`0.961`</small> | <small>`1.000`</small> | <small>`1.000`</small> |
| <small>true negative rate</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.036`</small> | <small>`0.133`</small> | <small>`0.589`</small> |
| <small>false positive rate</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.001`</small> | <small>`0.004`</small> |
| <small>false negative rate</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.003`</small> | <small>`0.018`</small> | <small>`0.098`</small> |

Broken down per language, the functional and performance measurements are in the table below.
			
| language | code | accuracy | precision | speedup | <small>words tested</small> | <small>true positive rate</small> | <small>true negative rate</small> | <small>false positive rate</small> | <small>false negative rate</small> |
|---|---|--:|--:|--:|--:|--:|--:|--:|--:|
| Afrikaans | `af_ZA` | `1.000` | `1.000` | `1.20` | <small>`125,470`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Aragonese | `an_ES` | `1.000` | `1.000` | `0.99` | <small>`20,535`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Arabic | `ar` | `1.000` | `1.000` | `1.80` | <small>`108,362`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Belarusian | `be_BY` | `1.000` | `1.000` | `1.52` | <small>`81,516`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Bulgarian | `bg_BG` | `1.000` | `1.000` | `1.25` | <small>`867,136`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Bengali | `bn_BD` | `1.000` | `1.000` | `1.67` | <small>`110,750`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Classical Tibetan | `bo` | `1.000` | `1.000` | `1.66` | <small>`376`</small> | <small>`0.918`</small> | <small>`0.082`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Breton | `br_FR` | `1.000` | `1.000` | `1.55` | <small>`464,631`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Bosnian | `bs_BA` | `1.000` | `1.000` | `1.20` | <small>`30,442`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Catalan | `ca` | `0.972` | `1.000` | `0.99` | <small>`655,679`</small> | <small>`0.968`</small> | <small>`0.004`</small> | <small>`0.000`</small> | <small>`0.028`</small> |
| Valencian | `ca_ES-valencia` | `0.972` | `1.000` | `1.00` | <small>`655,778`</small> | <small>`0.968`</small> | <small>`0.004`</small> | <small>`0.000`</small> | <small>`0.028`</small> |
| Czech | `cs_CZ` | `1.000` | `1.000` | `1.21` | <small>`165,085`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Danish | `da_DK` | `0.994` | `0.996` | `0.64` | <small>`390,462`</small> | <small>`0.942`</small> | <small>`0.052`</small> | <small>`0.004`</small> | <small>`0.002`</small> |
| Austrian German | `de_AT` | `1.000` | `1.000` | `0.45` | <small>`71,983`</small> | <small>`0.700`</small> | <small>`0.300`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Austrian German | `de_AT_frami` | `1.000` | `1.000` | `0.44` | <small>`250,806`</small> | <small>`0.677`</small> | <small>`0.323`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Swiss German | `de_CH` | `1.000` | `1.000` | `0.63` | <small>`381,038`</small> | <small>`0.943`</small> | <small>`0.057`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Swiss German | `de_CH_frami` | `1.000` | `1.000` | `0.56` | <small>`559,483`</small> | <small>`0.855`</small> | <small>`0.145`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| German | `de_DE` | `1.000` | `1.000` | `0.62` | <small>`380,890`</small> | <small>`0.943`</small> | <small>`0.057`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| German | `de_DE_frami` | `1.000` | `1.000` | `0.55` | <small>`559,844`</small> | <small>`0.856`</small> | <small>`0.144`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Dzongkha | `dz` | `1.000` | `1.000` | `1.63` | <small>`401`</small> | <small>`0.925`</small> | <small>`0.075`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Modern Greek | `el_GR` | `1.000` | `1.000` | `1.39` | <small>`828,785`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Australian English | `en_AU` | `1.000` | `1.000` | `1.45` | <small>`49,426`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Canadian English | `en_CA` | `1.000` | `1.000` | `1.31` | <small>`112,517`</small> | <small>`0.977`</small> | <small>`0.023`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| British English | `en_GB` | `1.000` | `1.000` | `0.98` | <small>`135,843`</small> | <small>`0.882`</small> | <small>`0.118`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| American English | `en_US` | `1.000` | `1.000` | `1.24` | <small>`112,568`</small> | <small>`0.976`</small> | <small>`0.024`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| South African English | `en_ZA` | `1.000` | `1.000` | `1.19` | <small>`53,537`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Esperanto | `eo` | `1.000` | `1.000` | `0.93` | <small>`1,015,192`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Spanish | `es_ES` | `1.000` | `1.000` | `0.61` | <small>`96,510`</small> | <small>`0.736`</small> | <small>`0.264`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Estonian | `et_EE` | `1.000` | `1.000` | `1.14` | <small>`282,173`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Basque | `eu` | `1.000` | `1.000` | `1.10` | <small>`106,346`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Farsi | `fa_IR` | `1.000` | `1.000` | `1.65` | <small>`331,788`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Faroese | `fo` | `1.000` | `1.000` | `1.03` | <small>`425,136`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| French | `fr` | `1.000` | `1.000` | `2.15` | <small>`191,661`</small> | <small>`0.996`</small> | <small>`0.004`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Irish | `ga_IE` | `1.000` | `1.000` | `1.14` | <small>`65,424`</small> | <small>`0.998`</small> | <small>`0.002`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Scottish Gaelic | `gd_GB` | `1.000` | `1.000` | `1.58` | <small>`334,794`</small> | <small>`0.992`</small> | <small>`0.008`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Galician | `gl_ES` | `1.000` | `1.000` | `1.02` | <small>`551,230`</small> | <small>`0.411`</small> | <small>`0.589`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Gujarati | `gu_IN` | `1.000` | `1.000` | `1.72` | <small>`168,952`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Guarani | `gug_PY` | `1.000` | `1.000` | `1.91` | <small>`4,215`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Manx Gaelic | `gv_GB` | `1.000` | `1.000` | `1.18` | <small>`32,358`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Hebrew | `he_IL` | `1.000` | `1.000` | `1.61` | <small>`469,730`</small> | <small>`0.974`</small> | <small>`0.026`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Hindi | `hi_IN` | `1.000` | `1.000` | `1.87` | <small>`15,983`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Croatian | `hr_HR` | `1.000` | `1.000` | `1.15` | <small>`53,395`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Hungarian | `hu_HU` | `1.000` | `1.000` | `1.59` | <small>`89,071`</small> | <small>`0.979`</small> | <small>`0.021`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Armenian | `hy_AM` | `1.000` | `1.000` | `2.08` | <small>`63,766`</small> | <small>`0.999`</small> | <small>`0.001`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Icelandic | `is_IS` | `1.000` | `1.000` | `1.35` | <small>`191,571`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Italian | `it_IT` | `1.000` | `1.000` | `1.27` | <small>`192,565`</small> | <small>`0.996`</small> | <small>`0.004`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Kazakh | `kk_KZ` | `0.907` | `1.000` | `1.04` | <small>`54,063`</small> | <small>`0.907`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.093`</small> |
| Kurmanji (Latin script) | `kmr_Latn` | `1.000` | `1.000` | `1.61` | <small>`4,735`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Laotian | `lo_LA` | `1.000` | `1.000` | `0.97` | <small>`18`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Lithuanian | `lt_LT` | `1.000` | `1.000` | `1.15` | <small>`82,627`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Latvian | `lv_LV` | `1.000` | `1.000` | `1.20` | <small>`155,631`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Malayalam | `ml_IN` | `1.000` | `1.000` | `1.68` | <small>`142,402`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Bokmål | `nb_NO` | `0.999` | `0.999` | `1.07` | <small>`939,921`</small> | <small>`0.954`</small> | <small>`0.045`</small> | <small>`0.001`</small> | <small>`0.000`</small> |
| Nepalese | `ne_NP` | `1.000` | `1.000` | `1.72` | <small>`34,604`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Dutch | `nl` | `1.000` | `1.000` | `0.56` | <small>`362,822`</small> | <small>`0.965`</small> | <small>`0.035`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Nynorsk | `nn_NO` | `1.000` | `1.000` | `1.43` | <small>`627,973`</small> | <small>`0.999`</small> | <small>`0.001`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Ndebele | `nr_ZA` | `1.000` | `1.000` | `1.13` | <small>`12,746`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Northern Sotho | `ns_ZA` | `1.000` | `1.000` | `1.27` | <small>`4,934`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Occitan | `oc_FR` | `1.000` | `1.000` | `1.16` | <small>`55,588`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Polish | `pl_PL` | `1.000` | `1.000` | `1.10` | <small>`3,802,878`</small> | <small>`0.990`</small> | <small>`0.010`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Brazilian | `pt_BR` | `0.902` | `1.000` | `0.92` | <small>`569,136`</small> | <small>`0.894`</small> | <small>`0.008`</small> | <small>`0.000`</small> | <small>`0.098`</small> |
| Portuguese | `pt_PT` | `1.000` | `1.000` | `1.30` | <small>`419,585`</small> | <small>`0.985`</small> | <small>`0.015`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Romanian | `ro_RO` | `1.000` | `1.000` | `1.59` | <small>`173,205`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Russian | `ru_RU` | `1.000` | `1.000` | `1.19` | <small>`146,269`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| North Sámi | `se` | `1.000` | `1.000` | `0.67` | <small>`527,510`</small> | <small>`0.546`</small> | <small>`0.454`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Sinhala | `si_LK` | `1.000` | `1.000` | `1.58` | <small>`30,319`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Slovak | `sk_SK` | `1.000` | `1.000` | `1.49` | <small>`246,224`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Slovene | `sl_SI` | `1.000` | `1.000` | `1.26` | <small>`246,856`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Albanian | `sq_AL` | `1.000` | `1.000` | `1.18` | <small>`229,505`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Serbian (Latin script) | `sr_Latn_RS` | `1.000` | `1.000` | `1.47` | <small>`222,281`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Serbian (Cyrillic script) | `sr_RS` | `1.000` | `1.000` | `1.73` | <small>`222,288`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Swazi | `ss_ZA` | `1.000` | `1.000` | `1.17` | <small>`18,969`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Southern Sotho | `st_ZA` | `1.000` | `1.000` | `1.16` | <small>`6,456`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Finland Swedish | `sv_FI` | `1.000` | `1.000` | `1.13` | <small>`151,274`</small> | <small>`0.977`</small> | <small>`0.023`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Swedish | `sv_SE` | `1.000` | `1.000` | `1.01` | <small>`247,754`</small> | <small>`0.968`</small> | <small>`0.032`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Swahili | `sw_TZ` | `1.000` | `1.000` | `1.13` | <small>`67,900`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Tagalog | `tl` | `1.000` | `1.000` | `1.25` | <small>`16,365`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Klingon | `tlh_Latn` | `1.000` | `1.000` | `1.61` | <small>`3,644`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Tswana | `tn_ZA` | `1.000` | `1.000` | `1.25` | <small>`10,865`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Tsonga | `ts_ZA` | `1.000` | `1.000` | `1.20` | <small>`28,354`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Ukrainian | `uk_UA` | `1.000` | `1.000` | `1.49` | <small>`1,486,067`</small> | <small>`0.878`</small> | <small>`0.122`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Uzbek | `uz_UZ` | `1.000` | `1.000` | `1.48` | <small>`97,000`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Venda | `ve_ZA` | `1.000` | `1.000` | `1.59` | <small>`8,785`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Vietnamese | `vi_VN` | `1.000` | `1.000` | `1.94` | <small>`6,631`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Xhosa | `xh_ZA` | `1.000` | `1.000` | `1.19` | <small>`18,121`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |
| Zulu | `zu_ZA` | `1.000` | `1.000` | `1.08` | <small>`73,194`</small> | <small>`1.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> | <small>`0.000`</small> |

			
Soon this information will also be offered in graphs, showing regression of performance in terms of functionality and speed over key commits to the source code repository.

# See also

Upcoming features improving performance are listed in the project's [roadmap](roadmap.html).
