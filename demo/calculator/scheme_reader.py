class Pair:
    """
    A pair has two instance attributes: first and second.

    For a Pair to be a well-formed list, second is either a
    well-formed list or nil.
    Some methods only apply to well-formed list.
    """

    def __init__(self, first, second):
        self.first = first
        self.second = second
