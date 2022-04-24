

import argparse


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Poorly constructed code to splice together vocab created from different tokenizers')
    parser.add_argument('--txt1', type=str, help='Vocab for one text" ', required=True)
    parser.add_argument('--txt2', type=str, help='Vocab for second text', required=True)
    parser.add_argument('--Output', type=str, help='Output Path for vocab', required=True)
    args = parser.parse_args()

    txt1 = args.txt1
    txt2 = args.txt2
    out_data = args.Output

    t1 = []
    t2 = []

    with open(txt1) as a_file:
        for line in a_file:
            t1.append(line)

    with open(txt2) as a_file:
        for line in a_file:
            t2.append(line) 


    final_vocab = list(set(t1 + t2))

    with open('{}/vocab.txt', 'w') as filehandle:
    for listitem in final_vocab:
        filehandle.write('%s\n' % listitem)
