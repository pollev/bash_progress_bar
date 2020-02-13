import progress_bar


total_iter = 50000000
progress_bar.init()
for i in range(total_iter):
    if i % 20 == 0: print("Hey There")
    progress_bar.fill(i, total_iter)
progress_bar.kill()