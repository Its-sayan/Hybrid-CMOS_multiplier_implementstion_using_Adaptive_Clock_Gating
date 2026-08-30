import matplotlib.pyplot as plt

# Data from your TikZ code
labels = ['Conventional CMOS', 'Hybrid', 'Proposed']
values = [3.93, 2.75, 1.05]
percentages = ['100%', '70.0%', '19.5%']
colors = ['#8da0cb', '#66c2a5', '#fc8d62'] # Soft blue, green, and red

fig, ax = plt.subplots(figsize=(8, 6))

# Create the bars
bars = ax.bar(labels, values, color=colors, edgecolor='black', alpha=0.8, width=0.6)

# Add the percentage labels at the bottom (or on top)
for bar, pct in zip(bars, percentages):
    height = bar.get_height()
    ax.text(bar.get_x() + bar.get_width()/2., height + 0.05, 
            pct, ha='center', va='bottom', fontweight='bold')

# Replicating the "Reduction" arrow/annotation
ax.annotate('80.5% (Reduction)', 
            xy=(2, 1.5), xytext=(2.5, 2.5),
            arrowprops=dict(facecolor='blue', shrink=0.05, width=2),
            color='blue', fontsize=10, fontweight='bold')

# Styling
ax.set_ylabel('Relative Power')
ax.set_xlabel('Design')
ax.set_title('Power Consumption Comparison')
ax.set_ylim(0, 4.5) # Leave room for labels

plt.tight_layout()
plt.show()