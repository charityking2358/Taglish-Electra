#Grab the Electra repo and Electra to Pytorch conversiion repos
git clone https://github.com/google-research/electra.git
git clone https://github.com/lonePatient/electra_pytorch.git


DATA_DIR=data
TRAIN_SIZE=1000000
TEST_BOOL=false
MODEL_NAME='taglish-electra'

echo "Processing Tagalog datasets"

mkdir -p $DATA_DIR
#Tagalog Dataset1
wget "https://s3.us-east-2.amazonaws.com/blaisecruz.com/datasets/tlunified/tlunified.zip" -O $DATA_DIR/tlunified.zip
#Tagalog Dataset2
wget "https://www.googleapis.com/drive/v3/files/1FN8F-HjPetfCXLgtNBGYFNB0MhHgA8IO?alt=media&key=AIzaSyDFdiwxGZkC1v_J4Q2u7e9vJ6QGSbdDsl8" -O $DATA_DIR/train1.txt
# English Dataset: OpenWebText ~500MB
wget "https://www.googleapis.com/drive/v3/files/16GOW1rDdjLnYhMYH637AyJSs7XsivgoN?alt=media&key=AIzaSyDFdiwxGZkC1v_J4Q2u7e9vJ6QGSbdDsl8" -O $DATA_DIR/eng_data1.txt
unzip $DATA_DIR/tlunified.zip -d $DATA_DIR/


if $TEST_BOOL
then 
	echo 'Using a small subset of each dataset'	
        head -n $TRAIN_SIZE $DATA_DIR/tlunified/train.txt >$DATA_DIR/train2_.txt
        head -n $TRAIN_SIZE $DATA_DIR/train1.txt > $DATA_DIR/train1_.txt
	head -n $TRAIN_SIZE $DATA_DIR/eng_data1.txt > $DATA_DIR/eng_data.txt 
        cat $DATA_DIR/train2_.txt $DATA_DIR/train1_.txt $DATA_DIR/eng_data.txt > $DATA_DIR/train_data.txt
        rm $DATA_DIR/tlunified.zip
        rm -rf $DATA_DIR/tlunified/
        rm $DATA_DIR/train1.txt
	rm $DATA_DIR/train2_.txt $DATA_DIR/train1_.txt
	rm $DATA_DIR/eng_data1.txt
	rm $DATA_DIR/eng_data.txt

else
	echo 'Using the Full Tagalog and English Datasets'
	cat $DATA_DIR/tlunified/train.txt $DATA_DIR/train1.txt $DATA_DIR/eng_data1.txt > $DATA_DIR/train_data.txt
	rm -rf $DATA_DIR/tlunified/
	rm $DATA_DIR/train1.txt
	rm $DATA_DIR/tlunified.zip
	rm $DATA_DIR/eng_data1.txt

		

fi

echo "Creating Filipino and English-Based tokenizers"
#Build Tokenizers
python tokenizer.py --Lang 'multilingual' --Data $DATA_DIR/train_data.txt --Output $DATA_DIR
