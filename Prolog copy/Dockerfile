FROM swipl:stable

COPY farmer.pl .

CMD ["swipl", "-s", "farmer.pl", "-g", "initial_state(InitialState), a_star(InitialState, Path)."]
# CMD ["swipl", "test."]
