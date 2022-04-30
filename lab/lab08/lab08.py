def make_generators_generator(g):
    """
    Generates all the "sub"-generators of the generator returned by
    the generator function g.

    >>> def every_m_ints_to(n, m):
    ...     i = 0
    ...     while (i <= n):
    ...         yield i
    ...         i += m
    ...
    >>> def every_3_ints_to_10():
    ...     for item in every_m_ints_to(10, 3):
    ...         yield item
    ...
    >>> for gen in make_generators_generator(every_3_ints_to_10):
    ...     print("Next Generator:")
    ...     for item in gen:
    ...         print(item)
    ...
    Next Generator:
    0
    Next Generator:
    0
    3
    Next Generator:
    0
    3
    6
    Next Generator:
    0
    3
    6
    9
    """
    # return a generator for every item in g()
    # for the xth generator, yield x items
    def gen_helper(num_next):
        gen = g()
        while num_next > 0:
            yield next(gen)
            num_next -= 1

    time = 1
    for item in g():
        yield gen_helper(time)
        time += 1
