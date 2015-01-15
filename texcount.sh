#!/bin/bash
# Created: Monday, October 27 2014
echo texcount "${1%.[^.]*}".tex -inc -total
