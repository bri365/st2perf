# -*- coding: utf-8 -*-
########################################################################
#
# Copyright (c) 2018, Plexxi Inc. and its licensors.
#
# All rights reserved.
#
# Use and duplication of this software is subject to a separate license
# agreement between the user and Plexxi or its licensor.
#
########################################################################


def a():
    x = []
    y = 1
    for i in range(1000000):
        x.append(y)


if __name__ == '__main__':
    a()
