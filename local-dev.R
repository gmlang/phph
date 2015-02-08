# install local package
install.packages("/Users/gmlang/openCPU/apps/phph", repos=NULL, type="source")
library(phph)

# run single server
library(opencpu)
opencpu$stop()
cleanup()
opencpu$start(2498)
# opencpu$browse("/github/gmlang/NormalToBinom/R/norm_to_binom/")

# run these lines at terminal
curl http://localhost:2498/ocpu/library/phph/R/run_descriptive/json -d ''
curl http://localhost:2498/ocpu/library/phph/R/run_descriptive2 -d ''
curl http://localhost:2498/ocpu/library/phph/R/run_descriptive -d ''

curl http://localhost:2498/ocpu/library/phph/R/km -d ''

# retrieve the plot
http://localhost:2498/ocpu/tmp/x064662d52f/R/.val
http://localhost:2498/ocpu/tmp/x0dc57f94f3/info
http://localhost:2498/ocpu/tmp/x0959fc73d8/stdout
http://localhost:2498/ocpu/tmp/x026aa6cc1f/graphics/1/png
http://localhost:2498/ocpu/tmp/x0b12271750/graphics/1/pdf
http://localhost:2498/ocpu/tmp/x09ee972d26/files/plt.png
