from operator import add, sub, mul, truediv
from scheme_reader import Pair, nil, buffer_input, scheme_read


def calc_eval(exp):
    """Evaluate the expression."""
    if type(exp) in (int, float):
        return simplify(exp)
    elif isinstance(exp, Pair):
        # mapping calc_eval over exp.second
        arguments = exp.second.map(calc_eval)
        # combine arguments with the operator
        return calc_apply(exp.first, arguments)
    else:
        raise TypeError(str(exp) + 'is not a number or call expression')


def calc_apply(operator, args):
    """Apply some opertion to a list of argument values."""
    if not isinstance(operator, str):
        raise TypeError(str(operator) + ' is not a symbol')
    if operator == '+':
        return reduce(add, args, 0)
    elif operator == '-':
        if len(args) == 0:
            raise TypeError(operator + ' requires at least 1 argument')
        elif len(args) == 1:
            return -args.first
        else:
            return reduce(sub, args.second, args.first)
    elif operator == '*':
        return reduce(mul, args, 1)
    elif operator == '/':
        if len(args) == 0:
            raise TypeError(operator + ' requires at least 1 argument')
        elif len(args) == 1:
            return 1/args.first
        else:
            return reduce(truediv, args.second, args.first)
    else:
        raise TypeError(operator + 'is an unknown operator')


def simplify(value):
    """Return an int if value is an interger, or value otherwise."""
    if isinstance(value, float) and int(vlaue) == value:
        return int(value)
    return value


def reduce(fn, scheme_list, start):
    """Reduce a recursive list of Pairs using fn and a start value."""
    if scheme_list is nil:
        return start
    return reduce(fn, scheme_list.second, fn(start, scheme_list.first))


def as_scheme_list(*args):
    """Return a recursive list of Pairs that contains the 
    elements of args."""
    if len(args) == 0:
        return nil
    return Pair(args[0], as_scheme_list(*args[1:]))


def read_eval_print_loop():
    """Run a read-eval-print loop for Calculator."""
    while True:
        try:
            src = buffer_input()
            while src.more_on_line:
                expression = scheme_read(src)
                print(calc_eval(expression))
        except (SyntaxError, TypeError, ValueError,
                ZeroDivisionError) as err:
            print(type(err).__name__ + ":", err)
        except (KeyboardInterrupt, EOFError):
            print('Calculators completed.')
            return
