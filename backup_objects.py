import argparse
import json
import os


def get_config(filepath, key):
    filename = os.path.join(filepath, 'config.json')
    with open(filename, 'r') as t:
        key_data = json.load(t)
    val = key_data.get(key)
    return val


def main():
    def_path = os.path.abspath(os.path.dirname(__file__))
    vrs_num = '1.2'
    parser = argparse.ArgumentParser(
        description='Local MS SQL Server Object Backup',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
        usage=argparse.SUPPRESS
    )
    parser.add_argument(
        '-v', '--version',
        action='version',
        version='%(prog)s ' + vrs_num
    )
    parser.add_argument(
        '-s', '--server',
        default=get_config(def_path, 'serverList')[0],
        choices=get_config(def_path, 'serverList'),
        help='Server name'
    )
    parser.add_argument(
        '-d', '--database',
        default=get_config(def_path, 'databaseList')[0],
        choices=get_config(def_path, 'databaseList'),
        help='Database to script'
    )

    args = parser.parse_args()
    config = vars(args)
    server = config['server']
    database = config['database']

    output_path = os.path.join(def_path, database)
    if not os.path.isdir(output_path):
        os.mkdir(output_path)

    cmd_text = f'mssql-scripter -S {server} -d {database}'
    cmd_text = cmd_text + ' --file-per-object'
    cmd_text = cmd_text + ' --script-create'
    cmd_text = cmd_text + ' --exclude-headers'
    cmd_text = cmd_text + ' --display-progress'
    cmd_text = cmd_text + f' -f {output_path}'
    if os.getcwd != def_path:
        os.chdir(def_path)
    os.system('cmd /C ' + cmd_text)


if __name__ == '__main__':
    main()
