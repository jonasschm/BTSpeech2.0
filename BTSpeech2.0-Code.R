
# The only necessary step before executing the code is to change the working path to the 
# folder with the collected protocols



# set working directory for using the function on all protocols / xmls
xml_dir <- "C:/Daten/protocols"


# Now just run the remaining code


# Create an empty tibble data frame
dta <- tibble(
    filename = character(),
    date = character(),
    name = character(),
    id   = character(),
    party= character(),
    text = character()
)

# write a function which reads each single xml file (protocol provided by the German Bundestag) and creates an tibble data frame with columns date, name & text
extract_from_xml <- function(xml_file) {
    
    # Read the xml file
    df<- read_xml(xml_file)
    
    # Get the date of the speech
    date <-xml_find_first(df, xpath = "//vorspann/kopfdaten/veranstaltungsdaten/datum")
    date <- xml_attr(date, "date")
    
    # extract all speeches of the protocol
    speeches <- xml_find_all(df, xpath = "//rede")
    
    # loop to extract all single speeches together with name of the speaker
    for (speech in speeches) {
        
        name <- paste(xml_text(xml_find_first(speech, ".//vorname")), xml_text(xml_find_first(speech, ".//nachname")))
        id <- xml_attr(xml_find_first(speech, ".//redner"), "id")
        party <- xml_text(xml_find_first(speech, ".//fraktion"))
        textnodes <- xml_find_all(speech, ".//p[@klasse='J' or @klasse='J_1' or @klasse='O']")
        speechfrag <- xml_text(textnodes)
        speechtext<- paste(unlist(speechfrag), collapse =" ")
        
        # Create a tibble with date, name and text by using the global dta tibble frame by using <<-
        dta <<- add_row(dta, filename=basename(xml_file), date=date, name=name, id=id, party=party, text=speechtext)
    }
}



# read all xml files into one list file
xmls <- list.files(path=xml_dir, pattern="*.xml")

# Use the earlier developed function on all xml files contained in the list file
for (xml in xmls) {
    extract_from_xml(paste(xml_dir, xml, sep="/"))
}

view(dta)

save(dta, file = "allspeeches.RData")


