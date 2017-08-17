import argparse

from rope.base import libutils, project
from rope.refactor.extract import ExtractVariable


parser = argparse.ArgumentParser()
parser.add_argument('path', type=str)
parser.add_argument('file', type=str)
parser.add_argument('start', type=int)
parser.add_argument('end', type=int)

args = parser.parse_args()

project_path = args.path
base_project = project.Project(project_path)

file_path = args.file
resource = libutils.path_to_resource(base_project, file_path)

start, end = args.start - 1, args.end
extractor = ExtractVariable(base_project, resource, start, end)

changes = extractor.get_changes('extracted_variable', similar=True)

print(changes.get_description())
# base_project.do(changes)
