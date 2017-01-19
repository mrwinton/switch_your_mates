#!/usr/bin/env ruby

docker_container = `docker ps`.split.last
path = `pwd`.strip

docker_container_setting = "DOCKER_CONTAINER: '#{docker_container}'"

File.open('config/local_env.yml', 'w') { |file| file.write(docker_container_setting) }

unless File.exist?('shape_predictor_68_face_landmarks.dat.bz2')
  `curl -L -O https://downloads.sourceforge.net/project/dclib/dlib/v18.10/shape_predictor_68_face_landmarks.dat.bz2`
  `bzip2 -d shape_predictor_68_face_landmarks.dat.bz2`
end

`docker cp #{path}/shape_predictor_68_face_landmarks.dat #{docker_container}:/root/`
`docker cp #{path}/facemixer.py #{docker_container}:/root/`
`docker cp #{path}/faceswap.py #{docker_container}:/root/`
