# BTSpeech2.0
R script to extract textual data from **structured** parliamentary protocol files (XML) provided by the German Bundestag into an R data frame. Applicable to all protocols from the 19th legislative period onwards.

Unfortunately, the protocols provided by the [Bundestag Open Data Service](https://www.bundestag.de/services/opendata "Bundestag Open Data") are only available as structured XMLs when downloaded individually instead of the entire zip files. Therefore, in addition to the R code, I also provide a file with all protocols since the start of the 19th legislative period until 07.07.2023 (20th legislative period). For all protocols within the mentioned time period, the ready data set can be easily retrieved via the file "allspeeches.RData" without executing the code again. Future protocol files must be added individually to the input XML folder and the code re-executed.

Alternatively, unstructured XMLs of previous legislatures in the German Bundestag can be read out via my original package [BTSpeech](https://github.com/jonasschm/BTSpeech). However, due to the unstructured nature of the provided data, the speech extraction will not always be 100% accurate.
