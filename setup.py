from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setup(
    name='get-user-agent',
    version='0.0.0',
    author='David Hooton',
    author_email='get-user-agent@hooton.org',
    description='A package to fetch get-user-agent strings',
    long_description=long_description,
    long_description_content_type="text/markdown",
    url='https://github.com/djh00t/get-user-agent',
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        'requests',
        'beautifulsoup4',
    ],
    entry_points={
        'console_scripts': [
            'get-user-agent=get-user-agent.get-user-agent:main',
        ],
    },
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.6',
)
