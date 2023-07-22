
################################################################################
#    &&&....&&&    % BioMed 2023: Learning R Course in Summer of 2023                       #
#  &&&&&&..&&&&&&  % Teacher: Bo Li, Mingwei Liu                               #
#  &&&&&&&&&&&&&&  % Date: Jul. 22th, 2023                                     #
#   &&&&&&&&&&&&   %                                                           #
#     &&&&&&&&     % Environment: R version 4.2.3;                             #
#       &&&&       % Platform: x86_64-w64-mingw32/x64 (64-bit)                 #
#        &         %                                                           #
################################################################################

################################################################################
### code chunk number 03: Understanding the data objects and their structure.
################################################################################

### ****************************************************************************
### Step-01. Common data objects in our life. 

# 1) Number or values in R

v1 <- seq(from = 0, to = 5, by = 0.3)
print(v1)
length(v1)

is.character(v1)
is.numeric(v1)

v2 <- rnorm(100) # randomly
print(v2)
hist(v2)
mean(v2)
sd(v2)

# 2) Text in R

t1 <- letters
t2 <- LETTERS
is.character(t1)
is.numeric(t2)

t3 <- "I am a Chinese"
print(t3)

t4 <- c("Chongqing", "Wuhan", "Chengdu")
is.character(t4)

class(t4)

# 3) Image in R

# if (!require(EBImage)) BiocManager::install("EBImage")

library(png)
file <- readPNG("data/raw data/CQNU.png")
is.numeric(file)
class(file)
dim(file)

library(EBImage)
img <- readImage("data/raw data/Rlogo.png")
is.numeric(img)
display(img, method="raster")
print(img)
str(img) # check the structure 

img <- readImage("data/raw data/2007.jpg")
display(img, method="raster")
colorMode(img) <- Grayscale
print(img)
display(img, method="raster")

img <- readImage("data/raw data/CQNU.png")
display(img, method="raster")
print(img)

str(img)

dim(img@.Data)
img@.Data[1:20, 1:20, 1]
img@.Data[, , 1]

library(DT)
datatable(img@.Data[, , 1])

img@.Data[, , 1][img@.Data[, , 1] > 0.9] <- 0.000019
display(img)

img@.Data[, , 2][img@.Data[, , 1] == 0.000019] <- 0.988888

display(img, all=TRUE)

# 4) Audio in R

library(tuneR)

aud <- readWave('data/raw data/Running-water-1323.wav')

print(aud)

tuneR::play(aud)

plot(aud)

sound1 <- Wave(left=sample(-32768:32767, size=44100*5, replace=TRUE))
tuneR::play(sound1)

sound2 <- Wave(left=sample(-32768:32767, size=44100*5, replace=TRUE),
               right=sample(-3276:3276, size=44100*5, replace=TRUE))
tuneR::play(sound2)

# 5) Video in R

library(av)
file <- "D:/new_dir/Emeishan_yuege.mp4"
av_media_info(file)

# Extracting the audio
av_audio_convert(file, 'D:/new_dir/music.mp3', total_time = 60)
tuneR::play("D:/new_dir/music.mp3")

# Splitting a video file in a set of image files.
dir.create("images_from_mp4")
av_video_images(file, "D:/new_dir/images_from_mp4/")

library(ggplot2)
library(gapminder)
makeplot <- function() {
    datalist <- split(gapminder, gapminder$year) 
    lapply(datalist, function(data) {
        p <- ggplot(data, aes(gdpPercap, lifeExp, size = pop, color = continent)) + 
          scale_size("population", limits = range(gapminder$pop)) + geom_point() + ylim(20, 90) + 
          scale_x_log10(limits = range(gapminder$gdpPercap)) + ggtitle(data$year) + theme_classic() 
        print(p)
      })
}

# Play 1plot per sec, and use an interpolation filter to convert into 10 fps 
video_file1 <- file.path("D:/new_dir/",'new_video.mp4') 
av_capture_graphics(makeplot(),
                    video_file1,
                    1280,
                    720,
                    res = 144,
                    vfilter = 'framerate=fps=10') 

video_file2 <- file.path("D:/new_dir/",'new_music.mp4') 
av_capture_graphics(makeplot(),
                    video_file2,
                    1280,
                    720,
                    res = 144,
                    vfilter = 'framerate=fps=10',
                    audio = "D:/new_dir/music.mp3")

av::av_media_info(video_file)
tuneR::play("D:/new_dir/new_music.mp4")

# utils::browseURL(video_file)
### End of Step-01.
### ****************************************************************************

### ****************************************************************************
### Step-02. About vector in R. 

x <- 6

x <- 1:10

seq()
c()
-10:100
rnorm(100, mean = 0, sd = 1)

x <- c(1, 0.5, -5, 10)

length(x)

names(x)

names(x) <- letters[1:4]

print(x)

x[2]
x["b"]

### End of Step-02.
### ****************************************************************************

################################################################################
### End of chunk-01.
################################################################################
