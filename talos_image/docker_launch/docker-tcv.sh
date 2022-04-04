#bin/bash!


docker build --tag tcv_image .
docker run --name tcv -dit tcv_image
docker attach tcv
