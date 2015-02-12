# data structure
* status: tab, msg, seconds 
* tables: tab, name, n, has_caption, caption, header, value
* plots: tab, name, n, has_caption, caption
* prints: tab, name, n, has_caption, caption, stdout


when no values, the following fileds assume these values

* tab = ""
* msg = ""
* name = ""
* n = 0
* caption = ""
* stdout = ""
* header = NULL (or {} in json)
* value = NULL (or {} in json)