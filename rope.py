import argparse
from rope.base import project

parser = argparse.ArgumentParser()
parser.add_argument('path', type=str)

args = parser.parse_args()

project_path = args.path
base_project = project.Project(project_path)
