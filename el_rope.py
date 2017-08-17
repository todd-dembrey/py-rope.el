import argparse

from rope.base import libutils, project
from rope.base.fscommands import FileSystemCommands
from rope.refactor.extract import ExtractVariable


class EmacsSystemCommands(FileSystemCommands):
    def __init__(self, current_path):
        self.current_path = current_path

    def write(self, path, data):
        if path == self.current_path:
            print(data)
        else:
            super(EmacsSystemCommands, self).write(path, data)


parser = argparse.ArgumentParser()
parser.add_argument('path', type=str)
parser.add_argument('file', type=str)
parser.add_argument('start', type=int)
parser.add_argument('end', type=int)
parser.add_argument('name', type=str)

args = parser.parse_args()

file_path = args.file

file_system_commands = EmacsSystemCommands(file_path)

project_path = args.path
base_project = project.Project(project_path, fscommands=file_system_commands)

resource = libutils.path_to_resource(base_project, file_path)

start, end = args.start - 1, args.end
extractor = ExtractVariable(base_project, resource, start, end)

variable_name = args.name
changes = extractor.get_changes(variable_name, similar=True)

base_project.do(changes)

base_project.close()
