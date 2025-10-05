class Solution(object):
    def pacificAtlantic(self, heights):
        if not heights or not heights[0]:
            return []

        m, n = len(heights), len(heights[0])

        pacific = set()
        atlantic = set()

        def dfs(r, c, visited, prev_height):
            # boundary and height check
            if (
                r < 0 or c < 0 or r >= m or c >= n or
                (r, c) in visited or heights[r][c] < prev_height
            ):
                return
            visited.add((r, c))
            # explore 4 directions
            dfs(r+1, c, visited, heights[r][c])
            dfs(r-1, c, visited, heights[r][c])
            dfs(r, c+1, visited, heights[r][c])
            dfs(r, c-1, visited, heights[r][c])

        # Run DFS from Pacific and Atlantic borders
        for i in range(m):
            dfs(i, 0, pacific, heights[i][0])          # left edge
            dfs(i, n-1, atlantic, heights[i][n-1])     # right edge
        for j in range(n):
            dfs(0, j, pacific, heights[0][j])          # top edge
            dfs(m-1, j, atlantic, heights[m-1][j])     # bottom edge

        # Intersection of both reachable sets
        result = list(pacific & atlantic)
        return result

        