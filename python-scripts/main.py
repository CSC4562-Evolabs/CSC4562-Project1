import numpy as np
import tensorflow as tf
# import numpy as np
# import pandas as pd
import sys
import getopt
import csv
import datetime
import time


def train_model(training_data):
    train = np.genfromtxt(training_data, delimiter=",", dtype=str)
    train = train[1:]

    x_timestamp, x_train, y_train = np.split(train, [1, 6], 1)
    x_train = x_train.astype(float)
    y_train = y_train.astype(float)
    x_delta = [] #Delta is is microseconds!
    for i in range(np.size(x_timestamp)-1):
        #delta = delta1 - delta2
        try:
            delta1 = datetime.datetime.strptime(str(x_timestamp[i+1]),"['%Y-%m-%d %H:%M:%S.%f']")
            delta2 = datetime.datetime.strptime(str(x_timestamp[i]),"['%Y-%m-%d %H:%M:%S.%f']")
            x_delta.append(abs(((delta1.hour - delta2.hour) * 3.6e+9 + (delta1.minute - delta2.minute) * 6e+7 + (delta1.second - delta2.second) * 1e+6) - (delta1.microsecond - delta2.microsecond)))
        except:
            x_delta.append(0.0)
    #for row in x_delta:
    #    print(row)
    #for row in x_train:
    #    print(row)
    #for row in y_train:
    #    print(row)
    x_delta = np.array(x_delta)
    x_train = np.concatenate((x_delta, x_train))

def retrain_model(training_data):
    print("hello")


def evaluate_model(data, output):
    print("hi")


def test():
    print("i work")


def parse_sysargs(argv):
    func = ""
    infile = ""
    outfile = ""

    try:
        opts, args = getopt.getopt(argv[1:], "h:f:i:o:", ["help", "function=",
                                                          "input=", "output="])
    except:
        print("Invalid command: " + arg_help)
        sys.exit(2)

    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print(arg_help)
            sys.exit(2)
        elif opt in ("-f", "--function"):
            func = arg
        elif opt in ("-i", "--file"):
            infile = arg
        elif opt in ("-o", "--output"):
            outfile = arg
        else:
            print(arg_help)
            sys.exit(2)

    return func, infile, outfile


if __name__ == '__main__':
    arg_func = ""
    arg_infile = ""
    arg_outfile = ""
    arg_help = "./main.py -f <train|retrain|evaluate|test> -i <input file> -o <output file>".format(sys.argv[0])
    arg_func, arg_infile, arg_outfile = parse_sysargs(sys.argv)

    print(arg_func)
    print(arg_infile)
    print(arg_outfile)

    if arg_func == "train":
        train_model(arg_infile)
    elif arg_func == "retrain":
        retrain_model(arg_infile)
    elif arg_func == "evaluate":
        evaluate_model(arg_infile, arg_outfile)
    elif arg_func == "test":
        test()
    else:
        print(arg_help)
        sys.exit(2)

    # tee = tf.constant(4)
    # print(tee)
