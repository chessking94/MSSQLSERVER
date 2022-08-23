import argparse
import os

def main():
    def_path = os.path.abspath(os.path.dirname(__file__))
    vrs_num = '1.1'
    parser = argparse.ArgumentParser(
        description = 'Local MS SQL Server Object Backup',
        formatter_class = argparse.ArgumentDefaultsHelpFormatter,
        usage = argparse.SUPPRESS
    )
    parser.add_argument(
        '-v', '--version',
        action = 'version',
        version = '%(prog)s ' + vrs_num
    )
    parser.add_argument(
        '-s', '--server',
        default = 'HUNT-PC1',
        choices = ['HUNT-PC1'],
        help = 'Server name'
    )
    parser.add_argument(
        '-d', '--database',
        default = 'ChessAnalysis',
        choices = ['ChessAnalysis', 'MLB', 'NFL'],
        help = 'Database to script'
    )
    
    args = parser.parse_args()
    config = vars(args)
    server = config['server']
    database = config['database']

    output_path = os.path.join(def_path, database)
    if not os.path.isdir(output_path):
        os.mkdir(output_path)

    cmd_text = f'mssql-scripter -S {server} -d {database} --file-per-object --script-create --exclude-headers --display-progress -f {output_path}'
    if os.getcwd != def_path:
        os.chdir(def_path)
    os.system('cmd /C ' + cmd_text)


if __name__ == '__main__':
    main()
