library(devtools)
options(devtools.desc.author="'Guangming Lang <gmlang@cabaceo.com> [aut, cre]'")
options(devtools.desc.license="MIT")

# set paths
proj_path = file.path(Sys.getenv("HOME"), "openCPU/apps")

# initialize a package named phph
create(file.path(proj_path, "phph"))
setwd(file.path(proj_path, "phph"))

# add Imports
use_package("survival")
use_package("splines")
use_package("ggplot2")
use_package("nltm")

# create data-raw folder and ignore it in the bundled version of the pkg
use_data_raw()

# edit 
file.edit("DESCRIPTION")

# create document
document()

# install local package
install.packages("/Users/gmlang/openCPU/apps/phph", repos=NULL, type="source")
library(phph)

#####################################
# local test on openCPU server ######
#####################################

# run single server
library(opencpu)
opencpu$stop()
cleanup()
opencpu$start(2498)
# opencpu$browse("/github/gmlang/NormalToBinom/R/norm_to_binom/")

# run these lines at terminal
curl http://localhost:2498/ocpu/library/phph/R/run_descriptive/json -d ''
curl http://localhost:2498/ocpu/library/phph/R/run_descriptive -d ''
curl http://localhost:2498/ocpu/library/phph/R/run_descriptive2 -d ''
curl http://localhost:2498/ocpu/library/phph/R/km/json -d ''
curl http://localhost:2498/ocpu/library/phph/R/km -d ''
curl http://localhost:2498/ocpu/library/phph/R/cox/json -d ''
curl http://localhost:2498/ocpu/library/phph/R/cox -d ''
curl http://localhost:2498/ocpu/library/phph/R/po/json -d ''
curl http://localhost:2498/ocpu/library/phph/R/po -d ''
curl http://localhost:2498/ocpu/library/phph/R/phph/json -d ''
curl http://localhost:2498/ocpu/library/phph/R/phph -d ''

# retrieve the plot
http://localhost:2498/ocpu/tmp/x064662d52f/R/.val
http://localhost:2498/ocpu/tmp/x0dc57f94f3/info
http://localhost:2498/ocpu/tmp/x0d0a8b773b/console
http://localhost:2498/ocpu/tmp/x01efb582bf/stdout
http://localhost:2498/ocpu/tmp/x0318bf1618/graphics/1/png
http://localhost:2498/ocpu/tmp/x0b12271750/graphics/1/pdf
http://localhost:2498/ocpu/tmp/x09ee972d26/files/plt.png
