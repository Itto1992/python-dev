from copy import copy


def lcs(a, b):
    assert isinstance(a, str) and isinstance(b, str)

    # ensure a is always longer than b to save memory
    if len(a) < len(b):
        a, b = b, a

    dp = ['' for _ in range(len(b) + 1)]
    for i in range(len(a)):
        prev = copy(dp)
        for j in range(len(b)):
            if a[i] == b[j]:
                dp[j + 1] = dp[j] + a[i]
            else:
                dp[j + 1] = max(dp[j], prev[j + 1], key=len)

    return dp[-1]
