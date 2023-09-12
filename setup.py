from setuptools import setup, find_packages

setup(
    name='user_agent',
    version='0.1',
    packages=find_packages(),
    install_requires=[
        'requests',
        'beautifulsoup4',
    ],
    entry_points={
        'console_scripts': [
            'user_agent=user_agent.user_agent:main',
        ],
    },
)
