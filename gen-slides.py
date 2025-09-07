import os

imgs = [f for f in os.listdir('sample') if 'WEB' in f]

for img in imgs:
    print(f'<div class="swiper-slide"><img src="sample/{img}" alt="{img}"></div>')
