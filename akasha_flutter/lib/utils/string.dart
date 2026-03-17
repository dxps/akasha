String limitChars(String input, int maxChars) {
  const ellipsis = '…';
  if (input.length <= maxChars) return input;
  if (maxChars <= ellipsis.length) return ellipsis.substring(0, maxChars);
  return input.substring(0, maxChars - ellipsis.length) + ellipsis;
}
