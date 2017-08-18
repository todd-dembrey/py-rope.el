from epc.server import EPCServer


server = EPCServer(('localhost', 0))


@server.register_function
def echo(*a):
    return a


if __name__ == '__main__':
    server.print_port()  # needed for Emacs client

    server.serve_forever()
    server.logger.info('exit')
